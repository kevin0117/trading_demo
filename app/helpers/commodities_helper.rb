module CommoditiesHelper
  # Rails i-18n can replace print_action method
  def print_action(action)
    if action == "Buy"
      "買進"
    else
      "賣出"
    end
  end

  def print_deal_action(action)
    if action == "Buy"
      "賣出"
    else
      "買進"
    end
  end
end
