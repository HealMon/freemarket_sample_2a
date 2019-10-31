module ApplicationHelper
  def format_zipcode(zipcode)
    zipcode.insert(3, " - ")
  end

  def formated_address
    prefecture = Prefecture.find(current_user.prefecture_id).name
    return prefecture + current_user.city + current_user.address
  end

  def formated_address_name
    last_name = current_user.delivery_last_name
    first_name = current_user.delivery_first_name
    return last_name + first_name
  end

  def formated_card_number(card)
    return "************ " + card.last4
  end

  def formated_card_time_limit(card)
    month_str = card.exp_month.to_s
    month_str = "0" + month_str if month_str.length == 1
    year_str = card.exp_year.to_s[2..3]
    return month_str + " / " + year_str
  end

  def formated_card_brand(card)
    brand = card.brand

    if(brand == "Visa")
      return "https://www-mercari-jp.akamaized.net/assets/img/card/visa.svg?3466462615"
    elsif(brand == "MasterCard")
      return "https://www-mercari-jp.akamaized.net/assets/img/card/master-card.svg?3466462615"
    elsif(brand == "JCB")
      return "https://www-mercari-jp.akamaized.net/assets/img/card/jcb.svg?3466462615"
    elsif(brand == "American Express")
      return "https://www-mercari-jp.akamaized.net/assets/img/card/american_express.svg?3466462615"
    elsif(brand == "Discover")
      return "https://www-mercari-jp.akamaized.net/assets/img/card/discover.svg?3466462615"
    end
  end
end