module UtilisationsHelper

  include ::Ambling::Helper
  
  def pie_chart(heading, data_action, start_date, end_date)
      ambling_chart(:pie,  :data_file => url_for(:action => data_action, :escape => false, :start_date => start_date, :end_date => end_date),
                              :id => data_action.to_s, :width => 680, :height => 400,
                              :chart_settings => Ambling::Pie::Settings.new({
                                :decimals_separator => '.',
                                :pie => {
                                  :x => 320,
                                  :y => 220,
                                  :radius => 140,
                                  :colors => '#B40000,#F7941D,#0265AC',
                                  :outline_color => '#000000',
                                  :outline_alpha => 50,
                                },
                                :animation => {
                                  :pull_out_on_click => true,
                                },
                                :data_labels => {
                                  :show => cdata_section("<b>{title}: {percents}%25</b>")#, :radius => -50,
                                },
                                :legend => {
                                  :enabled => true, :x => 490, :y => 100, :width => 200, :text_color => '#000',
                                  :max_columns => 1, :spacing => 2, :text_size => 16,
                                  :key => {:size => 10}
                                },
                                :labels => {
                                  :label =>
                                    {:x => 150, :y => 10, :text => cdata_section("<b>#{heading}</b>"),
                                      :text_size => 24, :text_color => '#0265AC'},
                                }
                              }).to_xml
                              ) do
                          content_tag('p', "To see this page properly, you need to upgrade your Flash Player")
      end
  end
  
end