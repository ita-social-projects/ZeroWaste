module Account::ProductsHelper
  def collection
    [
      [I18n.t("sort.id_asc"), "id asc"],
      [I18n.t("sort.id_desc"), "id desc"],
      [I18n.t("sort.title_asc"), "title asc"],
      [I18n.t("sort.title_desc"), "title desc"]
    ]
  end
end
