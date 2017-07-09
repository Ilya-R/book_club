module ApplicationHelper
 # <footer class="footer navbar navbar-default">
 # <div class="container" >
 # <div class="row" >
 # <div class="col-lg-12">
 # <div class="col-lg-6 navbar-brand" ><p>powered by <a href='https://www.github.com/Ilya-R/'>Илья Радушнов</a></p></div>
 #     <div class="col-lg-6"><%= link_to "Книжный клуб", root_path, class: "navbar-brand", style: "color:#000; float:right" %></div>
 # </div>
 #   </div>
 # </div>
#</footer>

  def fa_icon(icon_class)
    content_tag 'span', '', class: "fa fa-#{icon_class}"
  end
end
