class Note < ApplicationRecord
  validates :body, presence: true
  validates :title, presence: true, uniqueness: { case_sensitive: false, message: 'Ya existe una nota con este título.' }

  # Método para buscar notas por título con múltiples palabras y manejo de caracteres especiales
  def self.search_by_title(keywords)
    # Divide las palabras clave y aplica el filtro en forma acumulativa
    keywords.split.reduce(self) do |acc, word|
      acc.where("title LIKE ? ESCAPE '\\'", "%#{escape_sql_pattern(word)}%")
    end
  end

  private

  # Escapa caracteres especiales para evitar conflictos en LIKE
  def self.escape_sql_pattern(pattern)
    pattern.gsub(/[%_\\]/, '\\\\\\&')
  end
end
