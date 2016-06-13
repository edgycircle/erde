require "open3"

namespace :erde do
  desc "Outputs the schema file as PNG"
  task :png do
    schema_string = """digraph tables {
  node [shape=Mrecord rankdir=LR];
  table3 [label=\"{identities|<f1>id|email|password_digest}\"];
  table1 [label=\"{device_sessions|<f1>id|token|ip|location|browser|operating_system|created_at|updated_at}\"];
  table2 [label=\"{player_sessions|id|<f1>device_session_id|<f2>player_id|created_at}\"];
  table5 [label=\"{players|<f1>id|<f2>identity_id|name|avatar_uid}\"];
  table4 [label=\"{matches|<f1>id|<f2>winner_id|starting_score|number_of_legs|events|legs_needed_for_win|checkout_strategy|created_at|updated_at}\"];
  table6 [label=\"{players_matches|<f1>player_id|<f2>match_id}\"];

   table2:f1 -> table1:f1;
   table2:f2 -> table5:f1;
   table4:f2 -> table5:f1;
   table6:f1 -> table5:f1;
   table6:f2 -> table4:f1;
   table5:f2 -> table3:f1;
}
    """

    layouted_graph, dot_log = Open3.capture3("dot -Tpng -o schema.png", stdin_data: schema_string)
  end
end
