# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2023_09_09_045949) do
  create_table "access_keys", primary_key: "access_key_id", charset: "utf8mb3", collation: "utf8mb3_general_ci", force: :cascade do |t|
    t.string "context", limit: 40, null: false
    t.string "key_hash", limit: 40, null: false
    t.bigint "user_id", null: false
    t.bigint "assoc_id"
    t.datetime "expiry_date", precision: nil, null: false
    t.index ["key_hash", "user_id", "context"], name: "access_keys_hash"
  end

  create_table "announcement_settings", id: false, charset: "utf8mb3", collation: "utf8mb3_general_ci", force: :cascade do |t|
    t.bigint "announcement_id", null: false
    t.string "locale", limit: 14, default: "", null: false
    t.string "setting_name", null: false
    t.text "setting_value"
    t.string "setting_type", limit: 6
    t.index ["announcement_id", "locale", "setting_name"], name: "announcement_settings_pkey", unique: true
    t.index ["announcement_id"], name: "announcement_settings_announcement_id"
  end

  create_table "announcement_type_settings", id: false, charset: "utf8mb3", collation: "utf8mb3_general_ci", force: :cascade do |t|
    t.bigint "type_id", null: false
    t.string "locale", limit: 14, default: "", null: false
    t.string "setting_name", null: false
    t.text "setting_value"
    t.string "setting_type", limit: 6, null: false
    t.index ["type_id", "locale", "setting_name"], name: "announcement_type_settings_pkey", unique: true
    t.index ["type_id"], name: "announcement_type_settings_type_id"
  end

  create_table "announcement_types", primary_key: "type_id", charset: "utf8mb3", collation: "utf8mb3_general_ci", force: :cascade do |t|
    t.integer "assoc_type", limit: 2, null: false
    t.bigint "assoc_id", null: false
    t.index ["assoc_type", "assoc_id"], name: "announcement_types_assoc"
  end

  create_table "announcements", primary_key: "announcement_id", charset: "utf8mb3", collation: "utf8mb3_general_ci", force: :cascade do |t|
    t.integer "assoc_type", limit: 2
    t.bigint "assoc_id", null: false
    t.bigint "type_id"
    t.date "date_expire"
    t.datetime "date_posted", precision: nil, null: false
    t.index ["assoc_type", "assoc_id"], name: "announcements_assoc"
  end

  create_table "api_tokens", charset: "latin1", collation: "latin1_swedish_ci", force: :cascade do |t|
    t.bigint "api_user_id", null: false
    t.text "token", null: false
    t.boolean "active", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["api_user_id"], name: "index_api_tokens_on_api_user_id"
  end

  create_table "api_users", charset: "latin1", collation: "latin1_swedish_ci", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_api_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_api_users_on_reset_password_token", unique: true
  end

  create_table "auth_sources", primary_key: "auth_id", charset: "utf8mb3", collation: "utf8mb3_general_ci", force: :cascade do |t|
    t.string "title", limit: 60, null: false
    t.string "plugin", limit: 32, null: false
    t.integer "auth_default", limit: 2, default: 0, null: false
    t.text "settings"
  end

  create_table "author_settings", id: false, charset: "utf8mb3", collation: "utf8mb3_general_ci", force: :cascade do |t|
    t.bigint "author_id", null: false
    t.string "locale", limit: 14, default: "", null: false
    t.string "setting_name", null: false
    t.text "setting_value"
    t.index ["author_id", "locale", "setting_name"], name: "author_settings_pkey", unique: true
    t.index ["author_id"], name: "author_settings_author_id"
  end

  create_table "authors", primary_key: "author_id", charset: "utf8mb3", collation: "utf8mb3_general_ci", force: :cascade do |t|
    t.string "email", limit: 90, null: false
    t.integer "include_in_browse", limit: 2, default: 1, null: false
    t.bigint "publication_id", null: false
    t.float "seq", limit: 53, default: 0.0, null: false
    t.bigint "user_group_id"
    t.index ["publication_id"], name: "authors_publication_id"
  end

  create_table "categories", primary_key: "category_id", charset: "utf8mb3", collation: "utf8mb3_general_ci", force: :cascade do |t|
    t.bigint "context_id", null: false
    t.bigint "parent_id", null: false
    t.bigint "seq"
    t.string "path", null: false
    t.text "image"
    t.index ["context_id", "parent_id"], name: "category_context_id"
    t.index ["context_id", "path"], name: "category_path", unique: true
  end

  create_table "category_settings", id: false, charset: "utf8mb3", collation: "utf8mb3_general_ci", force: :cascade do |t|
    t.bigint "category_id", null: false
    t.string "locale", limit: 14, default: "", null: false
    t.string "setting_name", null: false
    t.text "setting_value"
    t.string "setting_type", limit: 6, null: false, comment: "(bool|int|float|string|object)"
    t.index ["category_id", "locale", "setting_name"], name: "category_settings_pkey", unique: true
  end

  create_table "citation_settings", id: false, charset: "utf8mb3", collation: "utf8mb3_general_ci", force: :cascade do |t|
    t.bigint "citation_id", null: false
    t.string "locale", limit: 14, default: "", null: false
    t.string "setting_name", null: false
    t.text "setting_value"
    t.string "setting_type", limit: 6, null: false
    t.index ["citation_id", "locale", "setting_name"], name: "citation_settings_pkey", unique: true
    t.index ["citation_id"], name: "citation_settings_citation_id"
  end

  create_table "citations", primary_key: "citation_id", charset: "utf8mb3", collation: "utf8mb3_general_ci", force: :cascade do |t|
    t.bigint "publication_id", default: 0, null: false
    t.text "raw_citation", null: false
    t.bigint "seq", default: 0, null: false
    t.index ["publication_id", "seq"], name: "citations_publication_seq", unique: true
    t.index ["publication_id"], name: "citations_publication"
  end

  create_table "completed_payments", primary_key: "completed_payment_id", charset: "utf8mb3", collation: "utf8mb3_general_ci", force: :cascade do |t|
    t.datetime "timestamp", precision: nil, null: false
    t.bigint "payment_type", null: false
    t.bigint "context_id", null: false
    t.bigint "user_id"
    t.bigint "assoc_id"
    t.float "amount", limit: 53, null: false
    t.string "currency_code_alpha", limit: 3
    t.string "payment_method_plugin_name", limit: 80
  end

  create_table "controlled_vocab_entries", primary_key: "controlled_vocab_entry_id", charset: "utf8mb3", collation: "utf8mb3_general_ci", force: :cascade do |t|
    t.bigint "controlled_vocab_id", null: false
    t.float "seq", limit: 53
    t.index ["controlled_vocab_id", "seq"], name: "controlled_vocab_entries_cv_id"
  end

  create_table "controlled_vocab_entry_settings", id: false, charset: "utf8mb3", collation: "utf8mb3_general_ci", force: :cascade do |t|
    t.bigint "controlled_vocab_entry_id", null: false
    t.string "locale", limit: 14, default: "", null: false
    t.string "setting_name", null: false
    t.text "setting_value"
    t.string "setting_type", limit: 6, null: false
    t.index ["controlled_vocab_entry_id", "locale", "setting_name"], name: "c_v_e_s_pkey", unique: true
    t.index ["controlled_vocab_entry_id"], name: "c_v_e_s_entry_id"
  end

  create_table "controlled_vocabs", primary_key: "controlled_vocab_id", charset: "utf8mb3", collation: "utf8mb3_general_ci", force: :cascade do |t|
    t.string "symbolic", limit: 64, null: false
    t.bigint "assoc_type", default: 0, null: false
    t.bigint "assoc_id", default: 0, null: false
    t.index ["symbolic", "assoc_type", "assoc_id"], name: "controlled_vocab_symbolic", unique: true
  end

  create_table "custom_issue_orders", id: false, charset: "utf8mb3", collation: "utf8mb3_general_ci", force: :cascade do |t|
    t.bigint "issue_id", null: false
    t.bigint "journal_id", null: false
    t.float "seq", limit: 53, default: 0.0, null: false
    t.index ["issue_id"], name: "custom_issue_orders_pkey", unique: true
  end

  create_table "custom_section_orders", id: false, charset: "utf8mb3", collation: "utf8mb3_general_ci", force: :cascade do |t|
    t.bigint "issue_id", null: false
    t.bigint "section_id", null: false
    t.float "seq", limit: 53, default: 0.0, null: false
    t.index ["issue_id", "section_id"], name: "custom_section_orders_pkey", unique: true
  end

  create_table "data_object_tombstone_oai_set_objects", primary_key: "object_id", charset: "utf8mb3", collation: "utf8mb3_general_ci", force: :cascade do |t|
    t.bigint "tombstone_id", null: false
    t.bigint "assoc_type", null: false
    t.bigint "assoc_id", null: false
    t.index ["tombstone_id"], name: "data_object_tombstone_oai_set_objects_tombstone_id"
  end

  create_table "data_object_tombstone_settings", id: false, charset: "utf8mb3", collation: "utf8mb3_general_ci", force: :cascade do |t|
    t.bigint "tombstone_id", null: false
    t.string "locale", limit: 14, default: "", null: false
    t.string "setting_name", null: false
    t.text "setting_value"
    t.string "setting_type", limit: 6, null: false, comment: "(bool|int|float|string|object)"
    t.index ["tombstone_id", "locale", "setting_name"], name: "data_object_tombstone_settings_pkey", unique: true
    t.index ["tombstone_id"], name: "data_object_tombstone_settings_tombstone_id"
  end

  create_table "data_object_tombstones", primary_key: "tombstone_id", charset: "utf8mb3", collation: "utf8mb3_general_ci", force: :cascade do |t|
    t.bigint "data_object_id", null: false
    t.datetime "date_deleted", precision: nil, null: false
    t.string "set_spec", null: false
    t.string "set_name", null: false
    t.string "oai_identifier", null: false
    t.index ["data_object_id"], name: "data_object_tombstones_data_object_id"
  end

  create_table "edit_decisions", primary_key: "edit_decision_id", charset: "utf8mb3", collation: "utf8mb3_general_ci", force: :cascade do |t|
    t.bigint "submission_id", null: false
    t.bigint "review_round_id", null: false
    t.bigint "stage_id"
    t.integer "round", limit: 2, null: false
    t.bigint "editor_id", null: false
    t.integer "decision", limit: 2, null: false
    t.datetime "date_decided", precision: nil, null: false
    t.index ["editor_id"], name: "edit_decisions_editor_id"
    t.index ["submission_id"], name: "edit_decisions_submission_id"
  end

  create_table "email_log", primary_key: "log_id", charset: "utf8mb3", collation: "utf8mb3_general_ci", force: :cascade do |t|
    t.bigint "assoc_type", null: false
    t.bigint "assoc_id", null: false
    t.bigint "sender_id", null: false
    t.datetime "date_sent", precision: nil, null: false
    t.bigint "event_type"
    t.string "from_address"
    t.text "recipients"
    t.text "cc_recipients"
    t.text "bcc_recipients"
    t.string "subject"
    t.text "body"
    t.index ["assoc_type", "assoc_id"], name: "email_log_assoc"
  end

  create_table "email_log_users", id: false, charset: "utf8mb3", collation: "utf8mb3_general_ci", force: :cascade do |t|
    t.bigint "email_log_id", null: false
    t.bigint "user_id", null: false
    t.index ["email_log_id", "user_id"], name: "email_log_user_id", unique: true
  end

  create_table "email_templates", primary_key: "email_id", charset: "utf8mb3", collation: "utf8mb3_general_ci", force: :cascade do |t|
    t.string "email_key", limit: 64, null: false, comment: "Unique identifier for this email."
    t.bigint "context_id", null: false
    t.integer "enabled", limit: 2, default: 1, null: false
    t.index ["email_key", "context_id"], name: "email_templates_email_key", unique: true
  end

  create_table "email_templates_default", primary_key: "email_id", charset: "utf8mb3", collation: "utf8mb3_general_ci", force: :cascade do |t|
    t.string "email_key", limit: 64, null: false, comment: "Unique identifier for this email."
    t.integer "can_disable", limit: 2, default: 0, null: false
    t.integer "can_edit", limit: 2, default: 0, null: false
    t.bigint "from_role_id"
    t.bigint "to_role_id"
    t.bigint "stage_id"
    t.index ["email_key"], name: "email_templates_default_email_key"
  end

  create_table "email_templates_default_data", id: false, charset: "utf8mb3", collation: "utf8mb3_general_ci", force: :cascade do |t|
    t.string "email_key", limit: 64, null: false, comment: "Unique identifier for this email."
    t.string "locale", limit: 14, default: "en_US", null: false
    t.string "subject", limit: 120, null: false
    t.text "body"
    t.text "description"
    t.index ["email_key", "locale"], name: "email_templates_default_data_pkey", unique: true
  end

  create_table "email_templates_settings", id: false, charset: "utf8mb3", collation: "utf8mb3_general_ci", force: :cascade do |t|
    t.bigint "email_id", null: false
    t.string "locale", limit: 14, default: "", null: false
    t.string "setting_name", null: false
    t.text "setting_value"
    t.index ["email_id", "locale", "setting_name"], name: "email_settings_pkey", unique: true
    t.index ["email_id"], name: "email_settings_email_id"
  end

  create_table "event_log", primary_key: "log_id", charset: "utf8mb3", collation: "utf8mb3_general_ci", force: :cascade do |t|
    t.bigint "assoc_type", null: false
    t.bigint "assoc_id", null: false
    t.bigint "user_id", null: false
    t.datetime "date_logged", precision: nil, null: false
    t.bigint "event_type"
    t.text "message"
    t.integer "is_translated", limit: 2
    t.index ["assoc_type", "assoc_id"], name: "event_log_assoc"
  end

  create_table "event_log_settings", id: false, charset: "utf8mb3", collation: "utf8mb3_general_ci", force: :cascade do |t|
    t.bigint "log_id", null: false
    t.string "setting_name", null: false
    t.text "setting_value"
    t.string "setting_type", limit: 6, null: false, comment: "(bool|int|float|string|object)"
    t.index ["log_id", "setting_name"], name: "event_log_settings_pkey", unique: true
    t.index ["log_id"], name: "event_log_settings_log_id"
    t.index ["setting_name", "setting_value"], name: "event_log_settings_name_value", length: { setting_name: 50, setting_value: 150 }
  end

  create_table "files", primary_key: "file_id", id: { type: :bigint, unsigned: true }, charset: "utf8mb3", collation: "utf8mb3_general_ci", force: :cascade do |t|
    t.string "path", null: false
    t.string "mimetype", null: false
  end

  create_table "filter_groups", primary_key: "filter_group_id", charset: "utf8mb3", collation: "utf8mb3_general_ci", force: :cascade do |t|
    t.string "symbolic"
    t.string "display_name"
    t.string "description"
    t.string "input_type"
    t.string "output_type"
    t.index ["symbolic"], name: "filter_groups_symbolic", unique: true
  end

  create_table "filter_settings", id: false, charset: "utf8mb3", collation: "utf8mb3_general_ci", force: :cascade do |t|
    t.bigint "filter_id", null: false
    t.string "locale", limit: 14, default: "", null: false
    t.string "setting_name", null: false
    t.text "setting_value"
    t.string "setting_type", limit: 6, null: false
    t.index ["filter_id", "locale", "setting_name"], name: "filter_settings_pkey", unique: true
    t.index ["filter_id"], name: "filter_settings_id"
  end

  create_table "filters", primary_key: "filter_id", charset: "utf8mb3", collation: "utf8mb3_general_ci", force: :cascade do |t|
    t.bigint "filter_group_id", default: 0, null: false
    t.bigint "context_id", default: 0, null: false
    t.string "display_name"
    t.string "class_name"
    t.integer "is_template", limit: 2, default: 0, null: false
    t.bigint "parent_filter_id", default: 0, null: false
    t.bigint "seq", default: 0, null: false
  end

  create_table "genre_settings", id: false, charset: "utf8mb3", collation: "utf8mb3_general_ci", force: :cascade do |t|
    t.bigint "genre_id", null: false
    t.string "locale", limit: 14, default: "", null: false
    t.string "setting_name", null: false
    t.text "setting_value"
    t.string "setting_type", limit: 6, null: false, comment: "(bool|int|float|string|object)"
    t.index ["genre_id", "locale", "setting_name"], name: "genre_settings_pkey", unique: true
    t.index ["genre_id"], name: "genre_settings_genre_id"
  end

  create_table "genres", primary_key: "genre_id", charset: "utf8mb3", collation: "utf8mb3_general_ci", force: :cascade do |t|
    t.bigint "context_id", null: false
    t.bigint "seq", null: false
    t.integer "enabled", limit: 2, default: 1, null: false
    t.bigint "category", default: 1, null: false
    t.integer "dependent", limit: 2, default: 0, null: false
    t.integer "supplementary", limit: 2, default: 0, null: false
    t.string "entry_key", limit: 30
  end

  create_table "institutional_subscription_ip", primary_key: "institutional_subscription_ip_id", charset: "utf8mb3", collation: "utf8mb3_general_ci", force: :cascade do |t|
    t.bigint "subscription_id", null: false
    t.string "ip_string", limit: 40, null: false
    t.bigint "ip_start", null: false
    t.bigint "ip_end"
    t.index ["ip_end"], name: "institutional_subscription_ip_end"
    t.index ["ip_start"], name: "institutional_subscription_ip_start"
    t.index ["subscription_id"], name: "institutional_subscription_ip_subscription_id"
  end

  create_table "institutional_subscriptions", primary_key: "institutional_subscription_id", charset: "utf8mb3", collation: "utf8mb3_general_ci", force: :cascade do |t|
    t.bigint "subscription_id", null: false
    t.string "institution_name", null: false
    t.string "mailing_address"
    t.string "domain"
    t.index ["domain"], name: "institutional_subscriptions_domain"
    t.index ["subscription_id"], name: "institutional_subscriptions_subscription_id"
  end

  create_table "issue_files", primary_key: "file_id", charset: "utf8mb3", collation: "utf8mb3_general_ci", force: :cascade do |t|
    t.bigint "issue_id", null: false
    t.string "file_name", limit: 90, null: false
    t.string "file_type", null: false
    t.bigint "file_size", null: false
    t.bigint "content_type", null: false
    t.string "original_file_name", limit: 127
    t.datetime "date_uploaded", precision: nil, null: false
    t.datetime "date_modified", precision: nil, null: false
    t.index ["issue_id"], name: "issue_files_issue_id"
  end

  create_table "issue_galley_settings", id: false, charset: "utf8mb3", collation: "utf8mb3_general_ci", force: :cascade do |t|
    t.bigint "galley_id", null: false
    t.string "locale", limit: 14, default: "", null: false
    t.string "setting_name", null: false
    t.text "setting_value"
    t.string "setting_type", limit: 6, null: false, comment: "(bool|int|float|string|object)"
    t.index ["galley_id", "locale", "setting_name"], name: "issue_galley_settings_pkey", unique: true
    t.index ["galley_id"], name: "issue_galley_settings_galley_id"
  end

  create_table "issue_galleys", primary_key: "galley_id", charset: "utf8mb3", collation: "utf8mb3_general_ci", force: :cascade do |t|
    t.string "locale", limit: 14
    t.bigint "issue_id", null: false
    t.bigint "file_id", null: false
    t.string "label", limit: 32
    t.float "seq", limit: 53, default: 0.0, null: false
    t.string "url_path", limit: 64
    t.index ["issue_id"], name: "issue_galleys_issue_id"
    t.index ["url_path"], name: "issue_galleys_url_path"
  end

  create_table "issue_settings", id: false, charset: "utf8mb3", collation: "utf8mb3_general_ci", force: :cascade do |t|
    t.bigint "issue_id", null: false
    t.string "locale", limit: 14, default: "", null: false
    t.string "setting_name", null: false
    t.text "setting_value"
    t.string "setting_type", limit: 6, null: false
    t.index ["issue_id", "locale", "setting_name"], name: "issue_settings_pkey", unique: true
    t.index ["issue_id"], name: "issue_settings_issue_id"
    t.index ["setting_name", "setting_value"], name: "issue_settings_name_value", length: { setting_name: 50, setting_value: 150 }
  end

  create_table "issues", primary_key: "issue_id", charset: "utf8mb3", collation: "utf8mb3_general_ci", force: :cascade do |t|
    t.bigint "journal_id", null: false
    t.integer "volume", limit: 2
    t.string "number", limit: 40
    t.integer "year", limit: 2
    t.integer "published", limit: 2, default: 0, null: false
    t.integer "current", limit: 2, default: 0, null: false
    t.datetime "date_published", precision: nil
    t.datetime "date_notified", precision: nil
    t.datetime "last_modified", precision: nil
    t.integer "access_status", limit: 2, default: 1, null: false
    t.datetime "open_access_date", precision: nil
    t.integer "show_volume", limit: 2, default: 0, null: false
    t.integer "show_number", limit: 2, default: 0, null: false
    t.integer "show_year", limit: 2, default: 0, null: false
    t.integer "show_title", limit: 2, default: 0, null: false
    t.string "style_file_name", limit: 90
    t.string "original_style_file_name"
    t.string "url_path", limit: 64
    t.index ["journal_id"], name: "issues_journal_id"
    t.index ["url_path"], name: "issues_url_path"
  end

  create_table "item_views", id: false, charset: "utf8mb3", collation: "utf8mb3_general_ci", force: :cascade do |t|
    t.bigint "assoc_type", null: false
    t.bigint "assoc_id", null: false
    t.bigint "user_id"
    t.datetime "date_last_viewed", precision: nil
    t.index ["assoc_type", "assoc_id", "user_id"], name: "item_views_pkey", unique: true
  end

  create_table "jobs", id: { type: :bigint, unsigned: true }, charset: "utf8mb3", collation: "utf8mb3_general_ci", force: :cascade do |t|
    t.string "queue", null: false
    t.text "payload", size: :long, null: false
    t.integer "attempts", limit: 1, null: false, unsigned: true
    t.integer "reserved_at", unsigned: true
    t.integer "available_at", null: false, unsigned: true
    t.integer "created_at", null: false, unsigned: true
    t.index ["queue", "reserved_at"], name: "jobs_queue_reserved_at_index"
  end

  create_table "journal_settings", id: false, charset: "utf8mb3", collation: "utf8mb3_general_ci", force: :cascade do |t|
    t.bigint "journal_id", null: false
    t.string "locale", limit: 14, default: "", null: false
    t.string "setting_name", null: false
    t.text "setting_value", size: :medium
    t.string "setting_type", limit: 6
    t.index ["journal_id", "locale", "setting_name"], name: "journal_settings_pkey", unique: true
    t.index ["journal_id"], name: "journal_settings_journal_id"
  end

  create_table "journals", primary_key: "journal_id", charset: "utf8mb3", collation: "utf8mb3_general_ci", force: :cascade do |t|
    t.string "path", limit: 32, null: false
    t.float "seq", limit: 53, default: 0.0, null: false, comment: "Used to order lists of journals"
    t.string "primary_locale", limit: 14, null: false
    t.integer "enabled", limit: 2, default: 1, null: false, comment: "Controls whether or not the journal is considered \"live\" and will appear on the website. (Note that disabled journals may still be accessible, but only if the user knows the URL.)"
    t.index ["path"], name: "journals_path", unique: true
  end

  create_table "library_file_settings", id: false, charset: "utf8mb3", collation: "utf8mb3_general_ci", force: :cascade do |t|
    t.bigint "file_id", null: false
    t.string "locale", limit: 14, default: "", null: false
    t.string "setting_name", null: false
    t.text "setting_value"
    t.string "setting_type", limit: 6, null: false, comment: "(bool|int|float|string|object|date)"
    t.index ["file_id", "locale", "setting_name"], name: "library_file_settings_pkey", unique: true
    t.index ["file_id"], name: "library_file_settings_id"
  end

  create_table "library_files", primary_key: "file_id", charset: "utf8mb3", collation: "utf8mb3_general_ci", force: :cascade do |t|
    t.bigint "context_id", null: false
    t.string "file_name", null: false
    t.string "original_file_name", null: false
    t.string "file_type", null: false
    t.bigint "file_size", null: false
    t.integer "type", limit: 2, null: false
    t.datetime "date_uploaded", precision: nil, null: false
    t.datetime "date_modified", precision: nil, null: false
    t.bigint "submission_id", null: false
    t.integer "public_access", limit: 2, default: 0
    t.index ["context_id"], name: "library_files_context_id"
    t.index ["submission_id"], name: "library_files_submission_id"
  end

  create_table "metadata_description_settings", id: false, charset: "utf8mb3", collation: "utf8mb3_general_ci", force: :cascade do |t|
    t.bigint "metadata_description_id", null: false
    t.string "locale", limit: 14, default: "", null: false
    t.string "setting_name", null: false
    t.text "setting_value"
    t.string "setting_type", limit: 6, null: false
    t.index ["metadata_description_id", "locale", "setting_name"], name: "metadata_descripton_settings_pkey", unique: true
    t.index ["metadata_description_id"], name: "metadata_description_settings_id"
  end

  create_table "metadata_descriptions", primary_key: "metadata_description_id", charset: "utf8mb3", collation: "utf8mb3_general_ci", force: :cascade do |t|
    t.bigint "assoc_type", default: 0, null: false
    t.bigint "assoc_id", default: 0, null: false
    t.string "schema_namespace", null: false
    t.string "schema_name", null: false
    t.string "display_name"
    t.bigint "seq", default: 0, null: false
    t.index ["assoc_type", "assoc_id"], name: "metadata_descriptions_assoc"
  end

  create_table "metrics", id: false, charset: "utf8mb3", collation: "utf8mb3_general_ci", force: :cascade do |t|
    t.string "load_id", null: false
    t.bigint "context_id", null: false
    t.bigint "pkp_section_id"
    t.bigint "assoc_object_type"
    t.bigint "assoc_object_id"
    t.bigint "submission_id"
    t.bigint "representation_id"
    t.bigint "assoc_type", null: false
    t.bigint "assoc_id", null: false
    t.string "day", limit: 8
    t.string "month", limit: 6
    t.integer "file_type", limit: 2
    t.string "country_id", limit: 2
    t.string "region", limit: 2
    t.string "city"
    t.string "metric_type", null: false
    t.integer "metric", null: false
    t.index ["load_id"], name: "metrics_load_id"
    t.index ["metric_type", "context_id", "assoc_type", "assoc_id"], name: "metrics_metric_type_submission_id_assoc"
    t.index ["metric_type", "context_id"], name: "metrics_metric_type_context_id"
    t.index ["metric_type", "submission_id", "assoc_type"], name: "metrics_metric_type_submission_id_assoc_type"
  end

  create_table "navigation_menu_item_assignment_settings", id: false, charset: "utf8mb3", collation: "utf8mb3_general_ci", force: :cascade do |t|
    t.bigint "navigation_menu_item_assignment_id", null: false
    t.string "locale", limit: 14, default: "", null: false
    t.string "setting_name", null: false
    t.text "setting_value"
    t.string "setting_type", limit: 6, null: false
    t.index ["navigation_menu_item_assignment_id", "locale", "setting_name"], name: "navigation_menu_item_assignment_settings_pkey", unique: true
    t.index ["navigation_menu_item_assignment_id"], name: "assignment_settings_navigation_menu_item_assignment_id"
  end

  create_table "navigation_menu_item_assignments", primary_key: "navigation_menu_item_assignment_id", charset: "utf8mb3", collation: "utf8mb3_general_ci", force: :cascade do |t|
    t.bigint "navigation_menu_id", null: false
    t.bigint "navigation_menu_item_id", null: false
    t.bigint "parent_id"
    t.bigint "seq", default: 0
  end

  create_table "navigation_menu_item_settings", id: false, charset: "utf8mb3", collation: "utf8mb3_general_ci", force: :cascade do |t|
    t.bigint "navigation_menu_item_id", null: false
    t.string "locale", limit: 14, default: "", null: false
    t.string "setting_name", null: false
    t.text "setting_value", size: :long
    t.string "setting_type", limit: 6, null: false
    t.index ["navigation_menu_item_id", "locale", "setting_name"], name: "navigation_menu_item_settings_pkey", unique: true
    t.index ["navigation_menu_item_id"], name: "navigation_menu_item_settings_navigation_menu_id"
  end

  create_table "navigation_menu_items", primary_key: "navigation_menu_item_id", charset: "utf8mb3", collation: "utf8mb3_general_ci", force: :cascade do |t|
    t.bigint "context_id", null: false
    t.string "path", default: ""
    t.string "type", default: ""
  end

  create_table "navigation_menus", primary_key: "navigation_menu_id", charset: "utf8mb3", collation: "utf8mb3_general_ci", force: :cascade do |t|
    t.bigint "context_id", null: false
    t.string "area_name", default: ""
    t.string "title", null: false
  end

  create_table "notes", primary_key: "note_id", charset: "utf8mb3", collation: "utf8mb3_general_ci", force: :cascade do |t|
    t.bigint "assoc_type", null: false
    t.bigint "assoc_id", null: false
    t.bigint "user_id", null: false
    t.datetime "date_created", precision: nil, null: false
    t.datetime "date_modified", precision: nil
    t.string "title"
    t.text "contents"
    t.index ["assoc_type", "assoc_id"], name: "notes_assoc"
  end

  create_table "notification_mail_list", primary_key: "notification_mail_list_id", charset: "utf8mb3", collation: "utf8mb3_general_ci", force: :cascade do |t|
    t.string "email", limit: 90, null: false
    t.integer "confirmed", limit: 2, default: 0, null: false
    t.string "token", limit: 40, null: false
    t.bigint "context", null: false
    t.index ["email", "context"], name: "notification_mail_list_email_context", unique: true
  end

  create_table "notification_settings", id: false, charset: "utf8mb3", collation: "utf8mb3_general_ci", force: :cascade do |t|
    t.bigint "notification_id", null: false
    t.string "locale", limit: 14
    t.string "setting_name", limit: 64, null: false
    t.text "setting_value", null: false
    t.string "setting_type", limit: 6, null: false, comment: "(bool|int|float|string|object)"
    t.index ["notification_id", "locale", "setting_name"], name: "notification_settings_pkey", unique: true
  end

  create_table "notification_subscription_settings", primary_key: "setting_id", charset: "utf8mb3", collation: "utf8mb3_general_ci", force: :cascade do |t|
    t.string "setting_name", limit: 64, null: false
    t.text "setting_value", null: false
    t.bigint "user_id", null: false
    t.bigint "context", null: false
    t.string "setting_type", limit: 6, null: false, comment: "(bool|int|float|string|object)"
  end

  create_table "notifications", primary_key: "notification_id", charset: "utf8mb3", collation: "utf8mb3_general_ci", force: :cascade do |t|
    t.bigint "context_id", null: false
    t.bigint "user_id"
    t.bigint "level", null: false
    t.bigint "type", null: false
    t.datetime "date_created", precision: nil, null: false
    t.datetime "date_read", precision: nil
    t.bigint "assoc_type"
    t.bigint "assoc_id"
    t.index ["assoc_type", "assoc_id"], name: "notifications_assoc"
    t.index ["context_id", "level"], name: "notifications_context_id"
    t.index ["context_id", "user_id", "level"], name: "notifications_context_id_user_id"
    t.index ["user_id", "level"], name: "notifications_user_id_level"
  end

  create_table "oai_resumption_tokens", id: false, charset: "utf8mb3", collation: "utf8mb3_general_ci", force: :cascade do |t|
    t.string "token", limit: 32, null: false
    t.bigint "expire", null: false
    t.integer "record_offset", null: false
    t.text "params"
    t.index ["token"], name: "oai_resumption_tokens_pkey", unique: true
  end

  create_table "plugin_settings", id: false, charset: "utf8mb3", collation: "utf8mb3_general_ci", force: :cascade do |t|
    t.string "plugin_name", limit: 80, null: false
    t.bigint "context_id", null: false
    t.string "setting_name", limit: 80, null: false
    t.text "setting_value"
    t.string "setting_type", limit: 6, null: false, comment: "(bool|int|float|string|object)"
    t.index ["plugin_name", "context_id", "setting_name"], name: "plugin_settings_pkey", unique: true
    t.index ["plugin_name"], name: "plugin_settings_plugin_name"
  end

  create_table "publication_categories", id: false, charset: "utf8mb3", collation: "utf8mb3_general_ci", force: :cascade do |t|
    t.bigint "publication_id", null: false
    t.bigint "category_id", null: false
    t.index ["publication_id", "category_id"], name: "publication_categories_id", unique: true
  end

  create_table "publication_galley_settings", id: false, charset: "utf8mb3", collation: "utf8mb3_general_ci", force: :cascade do |t|
    t.bigint "galley_id", null: false
    t.string "locale", limit: 14, default: "", null: false
    t.string "setting_name", null: false
    t.text "setting_value"
    t.index ["galley_id", "locale", "setting_name"], name: "publication_galley_settings_pkey", unique: true
    t.index ["galley_id"], name: "publication_galley_settings_galley_id"
    t.index ["setting_name", "setting_value"], name: "publication_galley_settings_name_value", length: { setting_name: 50, setting_value: 150 }
  end

  create_table "publication_galleys", primary_key: "galley_id", charset: "utf8mb3", collation: "utf8mb3_general_ci", force: :cascade do |t|
    t.string "locale", limit: 14
    t.bigint "publication_id", null: false
    t.string "label"
    t.bigint "submission_file_id", unsigned: true
    t.float "seq", limit: 53, default: 0.0, null: false
    t.string "remote_url", limit: 2047
    t.integer "is_approved", limit: 2, default: 0, null: false
    t.string "url_path", limit: 64
    t.index ["publication_id"], name: "publication_galleys_publication_id"
    t.index ["submission_file_id"], name: "publication_galleys_submission_file_id_foreign"
    t.index ["url_path"], name: "publication_galleys_url_path"
  end

  create_table "publication_settings", id: false, charset: "utf8mb3", collation: "utf8mb3_general_ci", force: :cascade do |t|
    t.bigint "publication_id", null: false
    t.string "locale", limit: 14, default: "", null: false
    t.string "setting_name", null: false
    t.text "setting_value"
    t.index ["publication_id", "locale", "setting_name"], name: "publication_settings_pkey", unique: true
    t.index ["publication_id"], name: "publication_settings_publication_id"
    t.index ["setting_name", "setting_value"], name: "publication_settings_name_value", length: { setting_name: 50, setting_value: 150 }
  end

  create_table "publications", primary_key: "publication_id", charset: "utf8mb3", collation: "utf8mb3_general_ci", force: :cascade do |t|
    t.bigint "access_status", default: 0
    t.date "date_published"
    t.datetime "last_modified", precision: nil
    t.string "locale", limit: 14
    t.bigint "primary_contact_id"
    t.bigint "section_id"
    t.float "seq", limit: 53, default: 0.0, null: false
    t.bigint "submission_id", null: false
    t.integer "status", limit: 2, default: 1, null: false
    t.string "url_path", limit: 64
    t.bigint "version"
    t.index ["section_id"], name: "publications_section_id"
    t.index ["submission_id"], name: "publications_submission_id"
    t.index ["url_path"], name: "publications_url_path"
  end

  create_table "queries", primary_key: "query_id", charset: "utf8mb3", collation: "utf8mb3_general_ci", force: :cascade do |t|
    t.bigint "assoc_type", null: false
    t.bigint "assoc_id", null: false
    t.integer "stage_id", limit: 2, null: false
    t.float "seq", limit: 53, default: 0.0, null: false
    t.datetime "date_posted", precision: nil
    t.datetime "date_modified", precision: nil
    t.integer "closed", limit: 2, default: 0, null: false
    t.index ["assoc_type", "assoc_id"], name: "queries_assoc_id"
  end

  create_table "query_participants", id: false, charset: "utf8mb3", collation: "utf8mb3_general_ci", force: :cascade do |t|
    t.bigint "query_id", null: false
    t.bigint "user_id", null: false
    t.index ["query_id", "user_id"], name: "query_participants_pkey", unique: true
  end

  create_table "queued_payments", primary_key: "queued_payment_id", charset: "utf8mb3", collation: "utf8mb3_general_ci", force: :cascade do |t|
    t.datetime "date_created", precision: nil, null: false
    t.datetime "date_modified", precision: nil, null: false
    t.date "expiry_date"
    t.text "payment_data"
  end

  create_table "review_assignments", primary_key: "review_id", charset: "utf8mb3", collation: "utf8mb3_general_ci", force: :cascade do |t|
    t.bigint "submission_id", null: false
    t.bigint "reviewer_id", null: false
    t.text "competing_interests"
    t.integer "recommendation", limit: 2
    t.datetime "date_assigned", precision: nil
    t.datetime "date_notified", precision: nil
    t.datetime "date_confirmed", precision: nil
    t.datetime "date_completed", precision: nil
    t.datetime "date_acknowledged", precision: nil
    t.datetime "date_due", precision: nil
    t.datetime "date_response_due", precision: nil
    t.datetime "last_modified", precision: nil
    t.integer "reminder_was_automatic", limit: 2, default: 0, null: false
    t.integer "declined", limit: 2, default: 0, null: false
    t.integer "cancelled", limit: 2, default: 0, null: false
    t.bigint "reviewer_file_id"
    t.datetime "date_rated", precision: nil
    t.datetime "date_reminded", precision: nil
    t.integer "quality", limit: 2
    t.bigint "review_round_id", null: false
    t.integer "stage_id", limit: 2, null: false
    t.integer "review_method", limit: 2, default: 1, null: false
    t.integer "round", limit: 2, default: 1, null: false
    t.integer "step", limit: 2, default: 1, null: false
    t.bigint "review_form_id"
    t.integer "unconsidered", limit: 2
    t.index ["review_form_id"], name: "review_assignments_form_id"
    t.index ["reviewer_id", "review_id"], name: "review_assignments_reviewer_review"
    t.index ["reviewer_id"], name: "review_assignments_reviewer_id"
    t.index ["submission_id"], name: "review_assignments_submission_id"
  end

  create_table "review_files", id: false, charset: "utf8mb3", collation: "utf8mb3_general_ci", force: :cascade do |t|
    t.bigint "review_id", null: false
    t.bigint "submission_file_id", null: false, unsigned: true
    t.index ["review_id", "submission_file_id"], name: "review_files_pkey", unique: true
    t.index ["review_id"], name: "review_files_review_id"
    t.index ["submission_file_id"], name: "review_files_submission_file_id_foreign"
  end

  create_table "review_form_element_settings", id: false, charset: "utf8mb3", collation: "utf8mb3_general_ci", force: :cascade do |t|
    t.bigint "review_form_element_id", null: false
    t.string "locale", limit: 14, default: "", null: false
    t.string "setting_name", null: false
    t.text "setting_value"
    t.string "setting_type", limit: 6, null: false
    t.index ["review_form_element_id", "locale", "setting_name"], name: "review_form_element_settings_pkey", unique: true
    t.index ["review_form_element_id"], name: "review_form_element_settings_review_form_element_id"
  end

  create_table "review_form_elements", primary_key: "review_form_element_id", charset: "utf8mb3", collation: "utf8mb3_general_ci", force: :cascade do |t|
    t.bigint "review_form_id", null: false
    t.float "seq", limit: 53
    t.bigint "element_type"
    t.integer "required", limit: 2
    t.integer "included", limit: 2
    t.index ["review_form_id"], name: "review_form_elements_review_form_id"
  end

  create_table "review_form_responses", id: false, charset: "utf8mb3", collation: "utf8mb3_general_ci", force: :cascade do |t|
    t.bigint "review_form_element_id", null: false
    t.bigint "review_id", null: false
    t.string "response_type", limit: 6
    t.text "response_value"
    t.index ["review_form_element_id", "review_id"], name: "review_form_responses_pkey"
  end

  create_table "review_form_settings", id: false, charset: "utf8mb3", collation: "utf8mb3_general_ci", force: :cascade do |t|
    t.bigint "review_form_id", null: false
    t.string "locale", limit: 14, default: "", null: false
    t.string "setting_name", null: false
    t.text "setting_value"
    t.string "setting_type", limit: 6, null: false
    t.index ["review_form_id", "locale", "setting_name"], name: "review_form_settings_pkey", unique: true
    t.index ["review_form_id"], name: "review_form_settings_review_form_id"
  end

  create_table "review_forms", primary_key: "review_form_id", charset: "utf8mb3", collation: "utf8mb3_general_ci", force: :cascade do |t|
    t.bigint "assoc_type", null: false
    t.bigint "assoc_id", null: false
    t.float "seq", limit: 53
    t.integer "is_active", limit: 2
  end

  create_table "review_round_files", id: false, charset: "utf8mb3", collation: "utf8mb3_general_ci", force: :cascade do |t|
    t.bigint "submission_id", null: false
    t.bigint "review_round_id", null: false
    t.integer "stage_id", limit: 2, null: false
    t.bigint "submission_file_id", null: false, unsigned: true
    t.index ["submission_file_id"], name: "review_round_files_submission_file_id_foreign"
    t.index ["submission_id", "review_round_id", "submission_file_id"], name: "review_round_files_pkey", unique: true
    t.index ["submission_id"], name: "review_round_files_submission_id"
  end

  create_table "review_rounds", primary_key: "review_round_id", charset: "utf8mb3", collation: "utf8mb3_general_ci", force: :cascade do |t|
    t.bigint "submission_id", null: false
    t.bigint "stage_id"
    t.integer "round", limit: 2, null: false
    t.bigint "review_revision"
    t.bigint "status"
    t.index ["submission_id", "stage_id", "round"], name: "review_rounds_submission_id_stage_id_round_pkey", unique: true
    t.index ["submission_id"], name: "review_rounds_submission_id"
  end

  create_table "scheduled_tasks", id: false, charset: "utf8mb3", collation: "utf8mb3_general_ci", force: :cascade do |t|
    t.string "class_name", null: false
    t.datetime "last_run", precision: nil
    t.index ["class_name"], name: "scheduled_tasks_pkey", unique: true
  end

  create_table "section_settings", id: false, charset: "utf8mb3", collation: "utf8mb3_general_ci", force: :cascade do |t|
    t.bigint "section_id", null: false
    t.string "locale", limit: 14, default: "", null: false
    t.string "setting_name", null: false
    t.text "setting_value"
    t.string "setting_type", limit: 6, null: false, comment: "(bool|int|float|string|object)"
    t.index ["section_id", "locale", "setting_name"], name: "section_settings_pkey", unique: true
    t.index ["section_id"], name: "section_settings_section_id"
  end

  create_table "sections", primary_key: "section_id", charset: "utf8mb3", collation: "utf8mb3_general_ci", force: :cascade do |t|
    t.bigint "journal_id", null: false
    t.bigint "review_form_id"
    t.float "seq", limit: 53, default: 0.0, null: false
    t.integer "editor_restricted", limit: 2, default: 0, null: false
    t.integer "meta_indexed", limit: 2, default: 0, null: false
    t.integer "meta_reviewed", limit: 2, default: 1, null: false
    t.integer "abstracts_not_required", limit: 2, default: 0, null: false
    t.integer "hide_title", limit: 2, default: 0, null: false
    t.integer "hide_author", limit: 2, default: 0, null: false
    t.integer "is_inactive", limit: 2, default: 0, null: false
    t.bigint "abstract_word_count"
    t.index ["journal_id"], name: "sections_journal_id"
  end

  create_table "sessions", id: false, charset: "utf8mb3", collation: "utf8mb3_general_ci", force: :cascade do |t|
    t.string "session_id", limit: 128, null: false
    t.bigint "user_id"
    t.string "ip_address", limit: 39, null: false
    t.string "user_agent"
    t.bigint "created", default: 0, null: false
    t.bigint "last_used", default: 0, null: false
    t.integer "remember", limit: 2, default: 0, null: false
    t.text "data", null: false
    t.string "domain"
    t.index ["session_id"], name: "sessions_pkey", unique: true
    t.index ["user_id"], name: "sessions_user_id"
  end

  create_table "site", id: false, charset: "utf8mb3", collation: "utf8mb3_general_ci", force: :cascade do |t|
    t.bigint "redirect", default: 0, null: false, comment: "If not 0, redirect to the specified journal/conference/... site."
    t.string "primary_locale", limit: 14, null: false, comment: "Primary locale for the site."
    t.integer "min_password_length", limit: 2, default: 6, null: false
    t.string "installed_locales", limit: 1024, default: "en_US", null: false, comment: "Locales for which support has been installed."
    t.string "supported_locales", limit: 1024, comment: "Locales supported by the site (for hosted journals/conferences/...)."
    t.string "original_style_file_name"
  end

  create_table "site_settings", id: false, charset: "utf8mb3", collation: "utf8mb3_general_ci", force: :cascade do |t|
    t.string "setting_name", null: false
    t.string "locale", limit: 14, default: "", null: false
    t.text "setting_value"
    t.index ["setting_name", "locale"], name: "site_settings_pkey", unique: true
  end

  create_table "stage_assignments", primary_key: "stage_assignment_id", charset: "utf8mb3", collation: "utf8mb3_general_ci", force: :cascade do |t|
    t.bigint "submission_id", null: false
    t.bigint "user_group_id", null: false
    t.bigint "user_id", null: false
    t.datetime "date_assigned", precision: nil, null: false
    t.integer "recommend_only", limit: 2, default: 0, null: false
    t.integer "can_change_metadata", limit: 2, default: 0, null: false
    t.index ["submission_id", "user_group_id", "user_id"], name: "stage_assignment", unique: true
    t.index ["submission_id"], name: "stage_assignments_submission_id"
    t.index ["user_group_id"], name: "stage_assignments_user_group_id"
    t.index ["user_id"], name: "stage_assignments_user_id"
  end

  create_table "static_page_settings", id: false, charset: "utf8mb3", collation: "utf8mb3_general_ci", force: :cascade do |t|
    t.bigint "static_page_id", null: false
    t.string "locale", limit: 14, default: "", null: false
    t.string "setting_name", null: false
    t.text "setting_value", size: :long
    t.string "setting_type", limit: 6, null: false, comment: "(bool|int|float|string|object)"
    t.index ["static_page_id", "locale", "setting_name"], name: "static_page_settings_pkey", unique: true
    t.index ["static_page_id"], name: "static_page_settings_static_page_id"
  end

  create_table "static_pages", primary_key: "static_page_id", charset: "utf8mb3", collation: "utf8mb3_general_ci", force: :cascade do |t|
    t.string "path", null: false
    t.bigint "context_id", null: false
  end

  create_table "subeditor_submission_group", id: false, charset: "utf8mb3", collation: "utf8mb3_general_ci", force: :cascade do |t|
    t.bigint "context_id", null: false
    t.bigint "assoc_id", null: false
    t.bigint "assoc_type", null: false
    t.bigint "user_id", null: false
    t.index ["assoc_id", "assoc_type"], name: "subeditor_submission_group_assoc_id"
    t.index ["context_id", "assoc_id", "assoc_type", "user_id"], name: "section_editors_pkey", unique: true
    t.index ["context_id"], name: "section_editors_context_id"
    t.index ["user_id"], name: "subeditor_submission_group_user_id"
  end

  create_table "submission_comments", primary_key: "comment_id", charset: "utf8mb3", collation: "utf8mb3_general_ci", force: :cascade do |t|
    t.bigint "comment_type"
    t.bigint "role_id", null: false
    t.bigint "submission_id", null: false
    t.bigint "assoc_id", null: false
    t.bigint "author_id", null: false
    t.text "comment_title", null: false
    t.text "comments"
    t.datetime "date_posted", precision: nil
    t.datetime "date_modified", precision: nil
    t.integer "viewable", limit: 2
    t.index ["submission_id"], name: "submission_comments_submission_id"
  end

  create_table "submission_file_revisions", primary_key: "revision_id", id: { type: :bigint, unsigned: true }, charset: "utf8mb3", collation: "utf8mb3_general_ci", force: :cascade do |t|
    t.bigint "submission_file_id", null: false, unsigned: true
    t.bigint "file_id", null: false, unsigned: true
    t.index ["file_id"], name: "submission_file_revisions_file_id_foreign"
    t.index ["submission_file_id"], name: "submission_file_revisions_submission_file_id_foreign"
  end

  create_table "submission_file_settings", id: false, charset: "utf8mb3", collation: "utf8mb3_general_ci", force: :cascade do |t|
    t.bigint "submission_file_id", null: false
    t.string "locale", limit: 14, default: "", null: false
    t.string "setting_name", null: false
    t.text "setting_value"
    t.string "setting_type", limit: 6, default: "string", null: false, comment: "(bool|int|float|string|object|date)"
    t.index ["submission_file_id", "locale", "setting_name"], name: "submission_file_settings_pkey", unique: true
    t.index ["submission_file_id"], name: "submission_file_settings_id"
  end

  create_table "submission_files", primary_key: "submission_file_id", id: { type: :bigint, unsigned: true }, charset: "utf8mb3", collation: "utf8mb3_general_ci", force: :cascade do |t|
    t.bigint "submission_id", null: false
    t.bigint "file_id", null: false, unsigned: true
    t.bigint "source_submission_file_id"
    t.bigint "genre_id"
    t.bigint "file_stage", null: false
    t.string "direct_sales_price"
    t.string "sales_type"
    t.integer "viewable", limit: 2
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.bigint "uploader_user_id"
    t.bigint "assoc_type"
    t.bigint "assoc_id"
    t.index ["file_id"], name: "submission_files_file_id_foreign"
    t.index ["file_stage", "assoc_type", "assoc_id"], name: "submission_files_stage_assoc"
    t.index ["submission_id"], name: "submission_files_submission_id"
  end

  create_table "submission_search_keyword_list", primary_key: "keyword_id", charset: "utf8mb3", collation: "utf8mb3_general_ci", force: :cascade do |t|
    t.string "keyword_text", limit: 60, null: false
    t.index ["keyword_text"], name: "submission_search_keyword_text", unique: true
  end

  create_table "submission_search_object_keywords", id: false, charset: "utf8mb3", collation: "utf8mb3_general_ci", force: :cascade do |t|
    t.bigint "object_id", null: false
    t.bigint "keyword_id", null: false
    t.integer "pos", null: false, comment: "Word position of the keyword in the object."
    t.index ["keyword_id"], name: "submission_search_object_keywords_keyword_id"
    t.index ["object_id", "pos"], name: "submission_search_object_keywords_pkey", unique: true
  end

  create_table "submission_search_objects", primary_key: "object_id", charset: "utf8mb3", collation: "utf8mb3_general_ci", force: :cascade do |t|
    t.bigint "submission_id", null: false
    t.integer "type", null: false, comment: "Type of item. E.g., abstract, fulltext, etc."
    t.bigint "assoc_id", comment: "Optional ID of an associated record (e.g., a file_id)"
    t.index ["submission_id"], name: "submission_search_object_submission"
  end

  create_table "submission_settings", id: false, charset: "utf8mb3", collation: "utf8mb3_general_ci", force: :cascade do |t|
    t.bigint "submission_id", null: false
    t.string "locale", limit: 14, default: "", null: false
    t.string "setting_name", null: false
    t.text "setting_value", size: :medium
    t.index ["submission_id", "locale", "setting_name"], name: "submission_settings_pkey", unique: true
    t.index ["submission_id"], name: "submission_settings_submission_id"
  end

  create_table "submission_tombstones", primary_key: "tombstone_id", charset: "utf8mb3", collation: "utf8mb3_general_ci", force: :cascade do |t|
    t.bigint "submission_id", null: false
    t.datetime "date_deleted", precision: nil, null: false
    t.bigint "journal_id", null: false
    t.bigint "section_id", null: false
    t.string "set_spec", null: false
    t.string "set_name", null: false
    t.string "oai_identifier", null: false
    t.index ["journal_id"], name: "submission_tombstones_journal_id"
    t.index ["submission_id"], name: "submission_tombstones_submission_id"
  end

  create_table "submissions", primary_key: "submission_id", charset: "utf8mb3", collation: "utf8mb3_general_ci", force: :cascade do |t|
    t.bigint "context_id", null: false
    t.bigint "current_publication_id"
    t.datetime "date_last_activity", precision: nil
    t.datetime "date_submitted", precision: nil
    t.datetime "last_modified", precision: nil
    t.bigint "stage_id", default: 1, null: false
    t.string "locale", limit: 14
    t.integer "status", limit: 2, default: 1, null: false
    t.integer "submission_progress", limit: 2, default: 1, null: false
    t.integer "work_type", limit: 2, default: 0
    t.index ["context_id"], name: "submissions_context_id"
    t.index ["current_publication_id"], name: "submissions_publication_id"
  end

  create_table "subscription_type_settings", id: false, charset: "utf8mb3", collation: "utf8mb3_general_ci", force: :cascade do |t|
    t.bigint "type_id", null: false
    t.string "locale", limit: 14, default: "", null: false
    t.string "setting_name", null: false
    t.text "setting_value"
    t.string "setting_type", limit: 6, null: false
    t.index ["type_id", "locale", "setting_name"], name: "subscription_type_settings_pkey", unique: true
    t.index ["type_id"], name: "subscription_type_settings_type_id"
  end

  create_table "subscription_types", primary_key: "type_id", charset: "utf8mb3", collation: "utf8mb3_general_ci", force: :cascade do |t|
    t.bigint "journal_id", null: false
    t.float "cost", limit: 53, null: false
    t.string "currency_code_alpha", limit: 3, null: false
    t.integer "non_expiring", limit: 2, default: 0, null: false
    t.integer "duration", limit: 2
    t.integer "format", limit: 2, null: false
    t.integer "institutional", limit: 2, default: 0, null: false
    t.integer "membership", limit: 2, default: 0, null: false
    t.integer "disable_public_display", limit: 2, null: false
    t.float "seq", limit: 53, null: false
  end

  create_table "subscriptions", primary_key: "subscription_id", charset: "utf8mb3", collation: "utf8mb3_general_ci", force: :cascade do |t|
    t.bigint "journal_id", null: false
    t.bigint "user_id", null: false
    t.bigint "type_id", null: false
    t.date "date_start"
    t.datetime "date_end", precision: nil
    t.integer "status", limit: 2, default: 1, null: false
    t.string "membership", limit: 40
    t.string "reference_number", limit: 40
    t.text "notes"
  end

  create_table "temporary_files", primary_key: "file_id", charset: "utf8mb3", collation: "utf8mb3_general_ci", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "file_name", limit: 90, null: false
    t.string "file_type"
    t.bigint "file_size", null: false
    t.string "original_file_name", limit: 127
    t.datetime "date_uploaded", precision: nil, null: false
    t.index ["user_id"], name: "temporary_files_user_id"
  end

  create_table "usage_stats_temporary_records", id: false, charset: "utf8mb3", collation: "utf8mb3_general_ci", force: :cascade do |t|
    t.bigint "assoc_id", null: false
    t.bigint "assoc_type", null: false
    t.bigint "day", null: false
    t.bigint "entry_time", null: false
    t.bigint "metric", default: 1, null: false
    t.string "country_id", limit: 2
    t.string "region", limit: 2
    t.string "city"
    t.string "load_id", null: false
    t.integer "file_type", limit: 2
  end

  create_table "user_group_settings", id: false, charset: "utf8mb3", collation: "utf8mb3_general_ci", force: :cascade do |t|
    t.bigint "user_group_id", null: false
    t.string "locale", limit: 14, default: "", null: false
    t.string "setting_name", null: false
    t.text "setting_value"
    t.string "setting_type", limit: 6, null: false, comment: "(bool|int|float|string|object)"
    t.index ["user_group_id", "locale", "setting_name"], name: "user_group_settings_pkey", unique: true
  end

  create_table "user_group_stage", id: false, charset: "utf8mb3", collation: "utf8mb3_general_ci", force: :cascade do |t|
    t.bigint "context_id", null: false
    t.bigint "user_group_id", null: false
    t.bigint "stage_id", null: false
    t.index ["context_id", "user_group_id", "stage_id"], name: "user_group_stage_pkey", unique: true
    t.index ["context_id"], name: "user_group_stage_context_id"
    t.index ["stage_id"], name: "user_group_stage_stage_id"
    t.index ["user_group_id"], name: "user_group_stage_user_group_id"
  end

  create_table "user_groups", primary_key: "user_group_id", charset: "utf8mb3", collation: "utf8mb3_general_ci", force: :cascade do |t|
    t.bigint "context_id", null: false
    t.bigint "role_id", null: false
    t.integer "is_default", limit: 2, default: 0, null: false
    t.integer "show_title", limit: 2, default: 1, null: false
    t.integer "permit_self_registration", limit: 2, default: 0, null: false
    t.integer "permit_metadata_edit", limit: 2, default: 0, null: false
    t.index ["context_id"], name: "user_groups_context_id"
    t.index ["role_id"], name: "user_groups_role_id"
    t.index ["user_group_id"], name: "user_groups_user_group_id"
  end

  create_table "user_interests", id: false, charset: "utf8mb3", collation: "utf8mb3_general_ci", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "controlled_vocab_entry_id", null: false
    t.index ["user_id", "controlled_vocab_entry_id"], name: "u_e_pkey", unique: true
  end

  create_table "user_settings", id: false, charset: "utf8mb3", collation: "utf8mb3_general_ci", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "locale", limit: 14, default: "", null: false
    t.string "setting_name", null: false
    t.bigint "assoc_type", default: 0, null: false
    t.bigint "assoc_id", default: 0, null: false
    t.text "setting_value"
    t.string "setting_type", limit: 6, null: false
    t.index ["setting_name", "locale"], name: "user_settings_locale_setting_name_index"
    t.index ["user_id", "locale", "setting_name", "assoc_type", "assoc_id"], name: "user_settings_pkey", unique: true
    t.index ["user_id"], name: "user_settings_user_id"
  end

  create_table "user_user_groups", id: false, charset: "utf8mb3", collation: "utf8mb3_general_ci", force: :cascade do |t|
    t.bigint "user_group_id", null: false
    t.bigint "user_id", null: false
    t.index ["user_group_id", "user_id"], name: "user_user_groups_pkey", unique: true
    t.index ["user_group_id"], name: "user_user_groups_user_group_id"
    t.index ["user_id"], name: "user_user_groups_user_id"
  end

  create_table "users", primary_key: "user_id", charset: "utf8mb3", collation: "utf8mb3_general_ci", force: :cascade do |t|
    t.string "username", limit: 32, null: false
    t.string "password", null: false
    t.string "email", null: false
    t.string "url", limit: 2047
    t.string "phone", limit: 32
    t.string "mailing_address"
    t.string "billing_address"
    t.string "country", limit: 90
    t.string "locales"
    t.text "gossip"
    t.datetime "date_last_email", precision: nil
    t.datetime "date_registered", precision: nil, null: false
    t.datetime "date_validated", precision: nil
    t.datetime "date_last_login", precision: nil, null: false
    t.integer "must_change_password", limit: 2
    t.bigint "auth_id"
    t.string "auth_str"
    t.integer "disabled", limit: 2, default: 0, null: false
    t.text "disabled_reason"
    t.integer "inline_help", limit: 2
    t.index ["email"], name: "users_email", unique: true
    t.index ["username"], name: "users_username", unique: true
  end

  create_table "versions", id: false, charset: "utf8mb3", collation: "utf8mb3_general_ci", force: :cascade do |t|
    t.integer "major", default: 0, null: false, comment: "Major component of version number, e.g. the 2 in OJS 2.3.8-0"
    t.integer "minor", default: 0, null: false, comment: "Minor component of version number, e.g. the 3 in OJS 2.3.8-0"
    t.integer "revision", default: 0, null: false, comment: "Revision component of version number, e.g. the 8 in OJS 2.3.8-0"
    t.integer "build", default: 0, null: false, comment: "Build component of version number, e.g. the 0 in OJS 2.3.8-0"
    t.datetime "date_installed", precision: nil, null: false
    t.integer "current", limit: 2, default: 0, null: false, comment: "1 iff the version entry being described is currently active. This permits the table to store past installation history for forensic purposes."
    t.string "product_type", limit: 30, comment: "Describes the type of product this row describes, e.g. \"plugins.generic\" (for a generic plugin) or \"core\" for the application itelf"
    t.string "product", limit: 30, comment: "Uniquely identifies the product this version row describes, e.g. \"ojs2\" for OJS 2.x, \"languageToggle\" for the language toggle block plugin, etc."
    t.string "product_class_name", limit: 80, comment: "Specifies the class name associated with this product, for plugins, or the empty string where not applicable."
    t.integer "lazy_load", limit: 2, default: 0, null: false, comment: "1 iff the row describes a lazy-load plugin; 0 otherwise"
    t.integer "sitewide", limit: 2, default: 0, null: false, comment: "1 iff the row describes a site-wide plugin; 0 otherwise"
    t.index ["product_type", "product", "major", "minor", "revision", "build"], name: "versions_pkey", unique: true
  end

  add_foreign_key "api_tokens", "api_users"
  add_foreign_key "publication_galleys", "submission_files", primary_key: "submission_file_id", name: "publication_galleys_submission_file_id_foreign"
  add_foreign_key "review_files", "submission_files", primary_key: "submission_file_id", name: "review_files_submission_file_id_foreign"
  add_foreign_key "review_round_files", "submission_files", primary_key: "submission_file_id", name: "review_round_files_submission_file_id_foreign"
  add_foreign_key "submission_file_revisions", "files", primary_key: "file_id", name: "submission_file_revisions_file_id_foreign"
  add_foreign_key "submission_file_revisions", "submission_files", primary_key: "submission_file_id", name: "submission_file_revisions_submission_file_id_foreign"
  add_foreign_key "submission_files", "files", primary_key: "file_id", name: "submission_files_file_id_foreign"
end
