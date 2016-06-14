require "open3"

namespace :erde do
  desc "Outputs the schema file as PNG"
  task :png do
#     schema_string = """digraph tables {
#   node [shape=Mrecord rankdir=LR];
#   table3 [label=\"{identities|<f1>id|email|password_digest}\"];
#   table1 [label=\"{device_sessions|<f1>id|token|ip|location|browser|operating_system|created_at|updated_at}\"];
#   table2 [label=\"{player_sessions|id|<f1>device_session_id|<f2>player_id|created_at}\"];
#   table5 [label=\"{players|<f1>id|<f2>identity_id|name|avatar_uid}\"];
#   table4 [label=\"{matches|<f1>id|<f2>winner_id|starting_score|number_of_legs|events|legs_needed_for_win|checkout_strategy|created_at|updated_at}\"];
#   table6 [label=\"{players_matches|<f1>player_id|<f2>match_id}\"];

#    table2:f1 -> table1:f1;
#    table2:f2 -> table5:f1;
#    table4:f2 -> table5:f1;
#    table6:f1 -> table5:f1;
#    table6:f2 -> table4:f1;
#    table5:f2 -> table3:f1;
# }
#     """

    schema_string = """
    [identities]
    id
    password
    email

    [players]
    id
    name
    identity_id

    players:identity_id -- identities:id
    """

    generated_hash = {}
    current_table = nil

    schema_string.lines.each do |line|
      cleaned_line = line.strip

      if current_table && cleaned_line.length > 0
        generated_hash[current_table]['columns'] << cleaned_line
      end

      if cleaned_line.length == 0
        current_table = nil
      end

      if match = cleaned_line.match(/^\[(\w+)\]/)
        current_table = match[1]
        generated_hash[current_table] = {}
        generated_hash[current_table]['columns'] = []
        generated_hash[current_table]['relations'] = {}
      end

      if match = cleaned_line.match(/^(\w+):(\w+) -- (\w+):(\w+)/)
        generated_hash[match[1]]['relations'][match[2]] = { table: match[3], column: match[4] }
      end
    end

    puts generated_hash.inspect

    schema_hash = {
      identities: {
        columns: [
          :id,
          :password,
          :email
        ],
        relations: {
        }
      },
      players: {
        columns: [
          :id,
          :name,
          :identity_id
        ],
        relations: {
          identity_id: { table: :identities, column: :id }
        }
      }
    }

    schema_string = ""
    schema_string << "digraph tables {"
    schema_string << "node [shape=Mrecord rankdir=LR];"

    schema_hash.each_pair do |table_name, table_schema|
      schema_string << "#{table_name} [label=\"{#{table_name}|#{table_schema[:columns].map {|c| "<#{c}>#{c}" }.join("|")}}\"];"

      table_schema[:relations].each_pair do |column, target|
        schema_string << "#{table_name}:#{column} -> #{target[:table]}:#{target[:column]};"
      end
    end

    schema_string << "}"

    puts schema_string

    layouted_graph, dot_log = Open3.capture3("dot -Tpng -o schema.png", stdin_data: schema_string)
  end
end
