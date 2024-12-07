# Limpia las notas existentes antes de generar nuevas
Note.destroy_all

# Generar 200 notas distintas
200.times do |i|
  title = "Nota #{i + 1}: #{('A'..'Z').to_a.sample(5).join}"
  content = "Contenido de la nota #{i + 1}: Lorem ipsum dolor sit amet."
  body = "Cuerpo detallado de la nota #{i + 1}."
  created_at = Time.at(rand((Time.now - 1.year).to_f..Time.now.to_f))

  Note.create!(
    title: title,
    content: content,
    body: body,
    created_at: created_at
  )
end

puts "200 notas creadas exitosamente."
