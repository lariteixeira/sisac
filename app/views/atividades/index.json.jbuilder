json.array!(@atividades) do |atividade|
  json.extract! atividade, :id, :nome, :status, :professor, :documento, :aluno
  json.url atividade_url(atividade, format: :json)
end
