module ApplicationHelper 
  ##
  # Displays full title of website, then page title

  def full_title(page_title = '')
     base_title = "MemoRabble"
     if page_title.empty?
       base_title
     else
       "#{ base_title } | #{ page_title }"
     end
   end

  # #
  # Psrocesses content of memo and prepares it for view
  # TODO: extract this ugly mess into the MemoParser gem

  def memo_content(input, remote: false)
    # #
    # NOTE: Thinking of using gsub?
    # You really done goofed now: https://github.com/rails/rails/issues/1555
    # tl;dr: Don't remove .to_str

    content = html_escape(input).to_str
    content = content.gsub(/@([a-z0-9A-Z]+)/) do |match|
      link_to "@#{ $1 }", memo_path($1), class: "marker", remote: remote
    end 
    content = Rinku.auto_link(content)
    content = simple_format content, {  }, sanitize: false
  end
end
