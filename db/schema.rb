# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20150921024031) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "alunos", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "usuario_id"
  end

  add_index "alunos", ["usuario_id"], name: "index_alunos_on_usuario_id", using: :btree

  create_table "atividades", force: :cascade do |t|
    t.string   "nome"
    t.string   "status"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.integer  "usuario_id"
    t.string   "motivo"
    t.text     "descricao"
    t.string   "aluno_id"
    t.string   "professor_id"
  end

  add_index "atividades", ["aluno_id"], name: "index_atividades_on_aluno_id", using: :btree
  add_index "atividades", ["professor_id"], name: "index_atividades_on_professor_id", using: :btree
  add_index "atividades", ["usuario_id"], name: "index_atividades_on_usuario_id", using: :btree

  create_table "comprovantes", force: :cascade do |t|
    t.integer  "atividade_id"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
    t.string   "arquivo_file_name"
    t.string   "arquivo_content_type"
    t.integer  "arquivo_file_size"
    t.datetime "arquivo_updated_at"
    t.integer  "tipo"
  end

  add_index "comprovantes", ["atividade_id"], name: "index_comprovantes_on_atividade_id", using: :btree

  create_table "declaracoes", force: :cascade do |t|
    t.text     "texto"
    t.integer  "tipo"
    t.string   "chave"
    t.string   "iduff"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "usuario_id"
    t.text     "tabela",     array: true
    t.integer  "aluno_id"
  end

  add_index "declaracoes", ["aluno_id"], name: "index_declaracoes_on_aluno_id", using: :btree
  add_index "declaracoes", ["usuario_id"], name: "index_declaracoes_on_usuario_id", using: :btree

  create_table "perfis", force: :cascade do |t|
    t.string   "nome"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "perfis_usuarios", force: :cascade do |t|
    t.integer "usuario_id"
    t.integer "perfil_id"
  end

  create_table "professores", force: :cascade do |t|
    t.boolean  "avaliador"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "usuario_id"
  end

  add_index "professores", ["usuario_id"], name: "index_professores_on_usuario_id", using: :btree

  create_table "professors", force: :cascade do |t|
    t.boolean  "avaliador"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "tipo_atividades", force: :cascade do |t|
    t.string   "nome"
    t.string   "descricao"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "usuarios", force: :cascade do |t|
    t.string   "nome"
    t.string   "categoria"
    t.string   "iduff"
    t.string   "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean  "avaliador"
    t.text     "descricao"
  end

  add_foreign_key "comprovantes", "atividades"
end
