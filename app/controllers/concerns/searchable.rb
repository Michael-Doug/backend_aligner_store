module Searchable
  extend ActiveSupport::Concern

  private

  # Colunas numéricas não aceitam LIKE no Postgres (operator does not exist:
  # numeric ~~ unknown), e LIKE em texto é case-sensitive.
  def apply_filters(scope, text: [], numeric: [])
    columns = scope.model.column_names

    text.each do |attribute|
      next unless columns.include?(attribute.to_s) && params[attribute].present?

      scope = scope.where("#{attribute} ILIKE ?", "%#{params[attribute]}%")
    end

    numeric.each do |attribute|
      next unless columns.include?(attribute.to_s) && params[attribute].present?

      scope = scope.where(attribute => params[attribute])
    end

    scope
  end
end
