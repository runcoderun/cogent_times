module UtilisationsHelper

  include ::Ambling::Helper
  
  def data_from(billings)
    chart = Ambling::Data::Pie.new
    ProjectCategory.reportable.each do |category|
      hours = billings.timesheets_for_category(category).sum &:hours
      chart.slices << Ambling::Data::Slice.new(hours, :title => category.name)
    end
    return chart
  end
  
  def pie_chart_settings(heading)
    Ambling::Pie::Settings.new({
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
    })
  end

  def cogent_times_chart(type, options)
    ambling_chart(type, options) do
      content_tag('p', "To see this page properly, you need to upgrade your Flash Player")
    end
  end
  
  def pie_chart(billings, heading)
    cogent_times_chart(:pie, :id => 'utilisation_pie', 
                       :width => 680, :height => 400,
                       :chart_data => data_from(billings).to_xml,
                       :chart_settings => pie_chart_settings(heading).to_xml)
  end
  
end