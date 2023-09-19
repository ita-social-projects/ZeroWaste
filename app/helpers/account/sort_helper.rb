module Account::SortHelper
  def products_criterias
    [
      [I18n.t("sort.id_asc"), "id asc"],
      [I18n.t("sort.id_desc"), "id desc"],
      [I18n.t("sort.title_asc"), "title asc"],
      [I18n.t("sort.title_desc"), "title desc"]
    ]
  end

  def calculators_criterias
    [
      [I18n.t("sort.id_asc"), "id asc"],
      [I18n.t("sort.id_desc"), "id desc"],
      [I18n.t("sort.name_asc"), "name asc"],
      [I18n.t("sort.name_desc"), "name desc"],
      [I18n.t("sort.slug_asc"), "slug asc"],
      [I18n.t("sort.slug_desc"), "slug desc"]
    ]
  end

  def users_criterias
    [
      [I18n.t("sort.id_asc"), "id asc"],
      [I18n.t("sort.id_desc"), "id desc"],
      [I18n.t("sort.email_asc"), "email asc"],
      [I18n.t("sort.email_desc"), "email desc"],
      [I18n.t("sort.last_sign_in_at_asc"), "last_sign_in_at asc"],
      [I18n.t("sort.last_sign_in_at_desc"), "last_sign_in_at desc"]
    ]
  end

  def categories_criterias
    [
      [I18n.t("sort.id_asc"), "id asc"],
      [I18n.t("sort.id_desc"), "id desc"],
      [I18n.t("sort.name_asc"), "name asc"],
      [I18n.t("sort.name_desc"), "name desc"],
      [I18n.t("sort.priority_asc"), "priority asc"],
      [I18n.t("sort.priority_desc"), "priority desc"]
    ]
  end
end
