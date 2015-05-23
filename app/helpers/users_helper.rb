module UsersHelper
    
    def job_title_icon
       if @user.profile.job_title == "Developer"
           "<i class='fa fa-code'></i>".html_safe
       elsif @user.profile.job_title == "Entrepreneur"
           "<i class='fa fa-lightbulb-o'></i>".html_safe
       elsif @user.profile.job_title == "Investor"
           "<i class='fa fa-dollar'></i>".html_safe
       end
    end
    
    def tel_to(text)
        groups = text.to_s.scan(/(?:^\+)?\d+/)
        if groups.size > 1 && groups[0][0] == '+'
            # remove leading 0 in area code if this is an international number
            groups[1] = groups[1][1..-1] if groups[1][0] == '0'
            groups.delete_at(1) if groups[1].size == 0 # remove if it was only a 0
        end
        link_to text, "tel:#{groups.join '-'}"
    end
    
end
