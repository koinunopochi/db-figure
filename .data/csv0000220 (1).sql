-- phpMyAdmin SQL Dump
-- version 5.2.2
-- https://www.phpmyadmin.net/
--
-- ホスト: db_hoisys
-- 生成日時: 2025 年 7 月 10 日 01:08
-- サーバのバージョン： 8.0.34
-- PHP のバージョン: 8.2.28

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- データベース: `csv0000220`
--

-- --------------------------------------------------------

--
-- テーブルの構造 `attendance_changeable_times`
--

CREATE TABLE `attendance_changeable_times` (
  `id` int UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `nursery_id` int UNSIGNED NOT NULL COMMENT '保育所ID',
  `attendance_time` time NOT NULL COMMENT '登園・出欠',
  `leaving_time` time NOT NULL COMMENT '降園'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- テーブルの構造 `b_accident_items`
--

CREATE TABLE `b_accident_items` (
  `item_id` bigint UNSIGNED NOT NULL COMMENT '項目ID',
  `item_name` varchar(255) COLLATE utf8mb4_general_ci NOT NULL COMMENT '項目名',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- テーブルの構造 `b_accident_regist_categories`
--

CREATE TABLE `b_accident_regist_categories` (
  `classify_id` bigint UNSIGNED NOT NULL COMMENT '分類ID',
  `nursery_id` int NOT NULL COMMENT '保育所ID',
  `item_id` int NOT NULL COMMENT 'アイテムID',
  `sort` int DEFAULT NULL COMMENT '表示順',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- テーブルの構造 `b_attendance_configs`
--

CREATE TABLE `b_attendance_configs` (
  `config_id` tinyint NOT NULL COMMENT '勤怠設定ID',
  `nursery_id` int NOT NULL DEFAULT '0' COMMENT '保育所ID',
  `config_flg` tinyint NOT NULL COMMENT '勤怠設定利用フラグ 0：利用しない 1：利用する',
  `counting_unit_arrived` tinyint NOT NULL COMMENT '集計単位',
  `counting_unit_left` tinyint NOT NULL COMMENT '退勤時間の集計単位',
  `time_set_arrived` tinyint NOT NULL COMMENT '出退勤時間の設定',
  `time_set_left` tinyint NOT NULL COMMENT '退勤時間の設定',
  `csv_output_setting` tinyint NOT NULL COMMENT 'CSVファイル出力設定',
  `break_time_disp_flg` tinyint NOT NULL COMMENT '休憩機能の利用設定 0：利用しない 1：利用する',
  `break_time_auto_input` tinyint NOT NULL DEFAULT '1' COMMENT '休憩時間自動入力の設定 0：自動入力しない 1：自動入力する',
  `closing_date_enabled` tinyint NOT NULL DEFAULT '0' COMMENT '勤怠締め日機能の利用設定 0：利用しない 1：利用する',
  `closing_date` tinyint NOT NULL DEFAULT '31' COMMENT '勤怠締め日',
  `edit_expiration_date` tinyint NOT NULL DEFAULT '0' COMMENT '締め日以降の編集有効期限',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- テーブルの構造 `b_business_log_items`
--

CREATE TABLE `b_business_log_items` (
  `item_id` bigint UNSIGNED NOT NULL COMMENT '項目ID',
  `item_name` varchar(255) COLLATE utf8mb4_general_ci NOT NULL COMMENT '項目名',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- テーブルの構造 `b_business_log_regist_categories`
--

CREATE TABLE `b_business_log_regist_categories` (
  `classify_id` bigint UNSIGNED NOT NULL COMMENT '分類ID',
  `nursery_id` int NOT NULL COMMENT '保育所ID',
  `item_id` int NOT NULL COMMENT 'アイテムID',
  `sort` tinyint DEFAULT NULL COMMENT '表示順',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- テーブルの構造 `b_certified_personal_shift_templates`
--

CREATE TABLE `b_certified_personal_shift_templates` (
  `personal_shift_id` int UNSIGNED NOT NULL COMMENT '個人シフトID',
  `employees_id` int NOT NULL COMMENT '社員ID',
  `week_day` tinyint NOT NULL COMMENT '曜日',
  `shift_id` int DEFAULT NULL COMMENT 'シフト管理ID',
  `attendance_time` time NOT NULL COMMENT '登園時間',
  `leaving_time` time NOT NULL COMMENT '降園時間',
  `break_time` time NOT NULL COMMENT '休憩時間',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- テーブルの構造 `b_certified_personal_shift_template_details`
--

CREATE TABLE `b_certified_personal_shift_template_details` (
  `personal_shift_detail_id` bigint UNSIGNED NOT NULL COMMENT '個人シフト詳細ID',
  `personal_shift_id` bigint NOT NULL COMMENT '個人シフトID',
  `engagement_category` tinyint NOT NULL COMMENT '従事区分:1:保育従事 2:その他',
  `attendance_time` time NOT NULL COMMENT '登園時間',
  `leaving_time` time NOT NULL COMMENT '降園時間',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- テーブルの構造 `b_certified_shift_templates`
--

CREATE TABLE `b_certified_shift_templates` (
  `shift_id` int UNSIGNED NOT NULL COMMENT 'シフト管理ID',
  `nursery_id` int NOT NULL COMMENT '保育所ID',
  `shift_name` varchar(10) COLLATE utf8mb4_general_ci NOT NULL COMMENT 'シフト名',
  `shift_color` varchar(10) COLLATE utf8mb4_general_ci NOT NULL COMMENT '色',
  `attendance_time` time NOT NULL COMMENT '登園時間',
  `leaving_time` time NOT NULL COMMENT '降園時間',
  `break_time` time NOT NULL COMMENT '休憩時間',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- テーブルの構造 `b_certified_shift_template_details`
--

CREATE TABLE `b_certified_shift_template_details` (
  `shift_detail_id` bigint UNSIGNED NOT NULL COMMENT 'シフト詳細ID',
  `shift_id` bigint NOT NULL COMMENT 'シフトID',
  `engagement_category` tinyint NOT NULL COMMENT '従事区分:1:保育従事 2:その他',
  `attendance_time` time NOT NULL COMMENT '登園時間',
  `leaving_time` time NOT NULL COMMENT '降園時間',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- テーブルの構造 `b_children`
--

CREATE TABLE `b_children` (
  `child_id` int UNSIGNED NOT NULL COMMENT '児童ID',
  `nursery_id` int NOT NULL COMMENT '保育所ID',
  `child_code` varchar(30) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '児童管理番号',
  `last_name` varchar(50) COLLATE utf8mb4_general_ci NOT NULL COMMENT '姓',
  `first_name` varchar(50) COLLATE utf8mb4_general_ci NOT NULL COMMENT '名',
  `last_name_kana` varchar(50) COLLATE utf8mb4_general_ci NOT NULL COMMENT '姓(カナ)',
  `first_name_kana` varchar(50) COLLATE utf8mb4_general_ci NOT NULL COMMENT '名(カナ)',
  `sex` tinyint NOT NULL COMMENT '性別 0：男性 1：女性',
  `date_of_birth` date NOT NULL COMMENT '生年月日',
  `blood_type` tinyint DEFAULT NULL COMMENT '血液型',
  `allergy_existence` tinyint DEFAULT NULL COMMENT 'アレルギー 0：なし 1：あり 他：未選択',
  `postal_code` varchar(7) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '郵便番号',
  `prefecture_id` tinyint DEFAULT NULL COMMENT '都道府県ID',
  `address1` varchar(40) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '住所1',
  `address2` varchar(40) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '住所2',
  `tel` varchar(14) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '自宅電話番号',
  `emergency_contact` varchar(14) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '緊急連絡先',
  `image_path` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '画像パス',
  `admission_date` date NOT NULL COMMENT '入所日',
  `leaving_date` date DEFAULT NULL COMMENT '退所日',
  `nurture_amount` tinyint NOT NULL COMMENT '保育必要量 0：標準時間 1：短時間',
  `growth_history_abnormal` tinyint(1) DEFAULT NULL COMMENT '生育歴(妊娠中)異常 0：なし 1：あり 他：未選択',
  `growth_history_etc` varchar(500) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '生育歴(妊娠中)その他',
  `growth_history_inspection` varchar(500) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '生育歴(妊娠中)その他の検査',
  `gestational_age` int DEFAULT NULL COMMENT '生育歴(出産期)在胎週数',
  `abnormal_labor` tinyint(1) DEFAULT NULL COMMENT '生育歴(出産期)分娩異常 0：なし 1：あり 他：未選択',
  `birth_period_height` decimal(7,1) DEFAULT NULL COMMENT '生育歴(出産期)身長',
  `birth_period_weight` decimal(7,1) DEFAULT NULL COMMENT '生育歴(出産期)体重',
  `birth_period_chest` decimal(7,1) DEFAULT NULL COMMENT '生育歴(出産期)胸囲',
  `birth_period_head` decimal(7,1) DEFAULT NULL COMMENT '生育歴(出産期)頭囲',
  `remarks` text COLLATE utf8mb4_general_ci COMMENT '備考',
  `token` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- テーブルの構造 `b_child_attendance_configs`
--

CREATE TABLE `b_child_attendance_configs` (
  `config_id` tinyint NOT NULL COMMENT '登降園設定ID',
  `counting_unit_arrived` tinyint NOT NULL COMMENT '集計ID',
  `counting_unit_left` tinyint NOT NULL COMMENT '退勤時間の集計単位',
  `time_set_arrived` tinyint NOT NULL COMMENT '登降園時間の設定',
  `time_set_left` tinyint NOT NULL COMMENT '降園時間の設定',
  `csv_output_setting` tinyint NOT NULL COMMENT 'CSV出力設定',
  `attendance_family_viewing` tinyint NOT NULL DEFAULT '1' COMMENT '登園時のお迎え予定の表示設定',
  `leaving_family_viewing` tinyint NOT NULL DEFAULT '1' COMMENT '降園時のお迎えの表示設定',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- テーブルの構造 `b_child_classes`
--

CREATE TABLE `b_child_classes` (
  `class_manage_id` int UNSIGNED NOT NULL COMMENT '所属クラス管理ID',
  `nursery_history_id` int UNSIGNED DEFAULT NULL COMMENT '保育所履歴ID',
  `child_id` int UNSIGNED NOT NULL COMMENT '児童ID',
  `class_id` int UNSIGNED NOT NULL COMMENT 'クラスID',
  `start_date` date NOT NULL COMMENT '開始日',
  `end_date` date NOT NULL COMMENT '終了日',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- テーブルの構造 `b_child_department_histories`
--

CREATE TABLE `b_child_department_histories` (
  `history_id` int UNSIGNED NOT NULL COMMENT '履歴ID',
  `child_id` int UNSIGNED NOT NULL COMMENT '児童ID',
  `nursery_id` int NOT NULL COMMENT '保育所ID',
  `admission_date` date NOT NULL COMMENT '入所日',
  `leaving_date` date DEFAULT NULL COMMENT '退所日',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- テーブルの構造 `b_child_monthly_fees`
--

CREATE TABLE `b_child_monthly_fees` (
  `manage_id` bigint UNSIGNED NOT NULL COMMENT '管理ID',
  `child_id` int NOT NULL COMMENT '児童ID',
  `fee_id` int NOT NULL COMMENT '月極金額ID',
  `price` int DEFAULT NULL COMMENT '金額',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- テーブルの構造 `b_child_support_terms`
--

CREATE TABLE `b_child_support_terms` (
  `id` bigint UNSIGNED NOT NULL COMMENT 'ID',
  `child_id` int NOT NULL COMMENT '児童ID',
  `from` date NOT NULL COMMENT '開始日',
  `to` date DEFAULT NULL COMMENT '終了日',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- テーブルの構造 `b_classes`
--

CREATE TABLE `b_classes` (
  `class_id` int UNSIGNED NOT NULL COMMENT 'クラスID',
  `class_name` varchar(255) COLLATE utf8mb4_general_ci NOT NULL COMMENT 'クラス名',
  `nursery_id` int NOT NULL COMMENT '保育所ID',
  `sort` int DEFAULT NULL COMMENT '表示順',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- テーブルの構造 `b_companies`
--

CREATE TABLE `b_companies` (
  `company_id` varchar(10) COLLATE utf8mb4_general_ci NOT NULL COMMENT '法人ID',
  `company_name` varchar(255) COLLATE utf8mb4_general_ci NOT NULL COMMENT '法人名',
  `company_name_kana` varchar(255) COLLATE utf8mb4_general_ci NOT NULL COMMENT '法人名(カナ)',
  `postal_code` varchar(7) COLLATE utf8mb4_general_ci NOT NULL COMMENT '郵便番号',
  `prefecture_id` tinyint NOT NULL COMMENT '都道府県ID',
  `address1` varchar(40) COLLATE utf8mb4_general_ci NOT NULL COMMENT '住所1',
  `address2` varchar(40) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '住所2',
  `tel` varchar(14) COLLATE utf8mb4_general_ci NOT NULL COMMENT '電話番号',
  `fax` varchar(14) COLLATE utf8mb4_general_ci NOT NULL COMMENT 'FAX番号',
  `representative_last_name` varchar(20) COLLATE utf8mb4_general_ci NOT NULL COMMENT '代表者 姓',
  `representative_first_name` varchar(20) COLLATE utf8mb4_general_ci NOT NULL COMMENT '代表者 名',
  `representative_last_name_kana` varchar(20) COLLATE utf8mb4_general_ci NOT NULL COMMENT '代表者 姓(カナ)',
  `representative_first_name_kana` varchar(20) COLLATE utf8mb4_general_ci NOT NULL COMMENT '代表者 名(カナ)',
  `person_in_charge_last_name` varchar(20) COLLATE utf8mb4_general_ci NOT NULL COMMENT '担当者 姓',
  `person_in_charge_first_name` varchar(20) COLLATE utf8mb4_general_ci NOT NULL COMMENT '担当者 名',
  `person_in_charge_last_name_kana` varchar(20) COLLATE utf8mb4_general_ci NOT NULL COMMENT '担当者 姓(カナ)',
  `person_in_charge_first_name_kana` varchar(20) COLLATE utf8mb4_general_ci NOT NULL COMMENT '担当者 名(カナ)',
  `person_in_charge_tel` varchar(14) COLLATE utf8mb4_general_ci NOT NULL COMMENT '担当者 電話番号',
  `person_in_charge_mail` varchar(255) COLLATE utf8mb4_general_ci NOT NULL COMMENT '担当者 メールアドレス',
  `remarks` text COLLATE utf8mb4_general_ci COMMENT '備考',
  `nursery_num` int NOT NULL COMMENT '保育所の登録可能数',
  `era_pattern` tinyint NOT NULL DEFAULT '1' COMMENT '年号表示種別:1:パターン1 2:パターン2 3:パターン3',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `login_key` varchar(8) COLLATE utf8mb4_general_ci NOT NULL COMMENT '管理ユーザーログイン用キー',
  `is_no_age_limit` tinyint(1) NOT NULL DEFAULT '0' COMMENT '年齢制限を解除'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- テーブルの構造 `b_configs`
--

CREATE TABLE `b_configs` (
  `config_id` bigint UNSIGNED NOT NULL COMMENT '設定ID',
  `category` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT 'カテゴリ',
  `item_name` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '項目名',
  `item_value` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '項目値',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- テーブルの構造 `b_daily_plan_items`
--

CREATE TABLE `b_daily_plan_items` (
  `item_id` int UNSIGNED NOT NULL COMMENT '項目ID',
  `item_name` varchar(255) COLLATE utf8mb4_general_ci NOT NULL COMMENT '項目名',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- テーブルの構造 `b_daily_plan_regist_categories`
--

CREATE TABLE `b_daily_plan_regist_categories` (
  `classify_id` bigint UNSIGNED NOT NULL COMMENT '分類ID',
  `nursery_id` int NOT NULL COMMENT '保育所ID',
  `class_id` int NOT NULL COMMENT 'クラスID',
  `item_id` int NOT NULL COMMENT 'アイテムID',
  `sort` tinyint DEFAULT NULL COMMENT '表示順',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- テーブルの構造 `b_developmental_record_categories`
--

CREATE TABLE `b_developmental_record_categories` (
  `item_id` bigint UNSIGNED NOT NULL COMMENT '領域ID',
  `item_name` varchar(255) COLLATE utf8mb4_general_ci NOT NULL COMMENT '領域名',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- テーブルの構造 `b_developmental_record_cate_regist_categories`
--

CREATE TABLE `b_developmental_record_cate_regist_categories` (
  `classify_id` bigint UNSIGNED NOT NULL COMMENT '分類ID',
  `nursery_id` int NOT NULL COMMENT '保育所ID',
  `item_id` int NOT NULL COMMENT '領域ID',
  `sort` int DEFAULT NULL COMMENT '表示順',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- テーブルの構造 `b_developmental_record_items`
--

CREATE TABLE `b_developmental_record_items` (
  `item_id` bigint UNSIGNED NOT NULL COMMENT '項目ID',
  `nursery_id` int NOT NULL COMMENT '保育所ID',
  `item_name` varchar(255) COLLATE utf8mb4_general_ci NOT NULL COMMENT '項目名',
  `achieve_from_year` int NOT NULL COMMENT '開始標準月齢(年)',
  `achieve_from_month` int NOT NULL COMMENT '開始標準月齢(月)',
  `achieve_to_year` int NOT NULL COMMENT '終了標準月齢(年)',
  `achieve_to_month` int NOT NULL COMMENT '終了標準月齢(月)',
  `available_start_date` date NOT NULL COMMENT '適用開始日',
  `available_end_date` date DEFAULT NULL COMMENT '適用終了日',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- テーブルの構造 `b_developmental_record_item_regist_categories`
--

CREATE TABLE `b_developmental_record_item_regist_categories` (
  `classify_id` bigint UNSIGNED NOT NULL COMMENT '分類ID',
  `nursery_id` int NOT NULL COMMENT '保育所ID',
  `category_id` int NOT NULL COMMENT '領域ID',
  `item_id` int NOT NULL COMMENT '項目ID',
  `sort` int DEFAULT NULL COMMENT '表示順',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- テーブルの構造 `b_employees`
--

CREATE TABLE `b_employees` (
  `employee_id` int UNSIGNED NOT NULL COMMENT '従業員ID',
  `nursery_id` int NOT NULL COMMENT '保育所ID',
  `last_name` varchar(50) COLLATE utf8mb4_general_ci NOT NULL COMMENT '姓',
  `first_name` varchar(50) COLLATE utf8mb4_general_ci NOT NULL COMMENT '名',
  `last_name_kana` varchar(50) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '姓(カナ)',
  `first_name_kana` varchar(50) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '名(カナ)',
  `sex` tinyint DEFAULT NULL COMMENT '性別',
  `date_of_birth` date DEFAULT NULL COMMENT '生年月日',
  `postal_code` varchar(7) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '郵便番号',
  `prefecture_id` tinyint DEFAULT NULL COMMENT '都道府県ID',
  `address1` varchar(40) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '住所1',
  `address2` varchar(40) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '住所2',
  `tel` varchar(14) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '電話番号',
  `mail` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT 'メールアドレス',
  `employee_code` varchar(30) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '従業員管理番号',
  `position_id` tinyint DEFAULT NULL COMMENT '役職ID',
  `employment_pattern_id` tinyint DEFAULT NULL COMMENT '雇用形態ID',
  `working_form` tinyint DEFAULT NULL COMMENT '勤務形態 0：未選択 1：常勤 2：非常勤',
  `working_form_start` date NOT NULL COMMENT '勤務形態開始日',
  `working_form_end` date DEFAULT NULL COMMENT '勤務形態終了日',
  `entrance_date` date NOT NULL COMMENT '入社日',
  `leaving_date` date DEFAULT NULL COMMENT '退社日',
  `belong_from` date NOT NULL COMMENT '所属開始日',
  `belong_to` date DEFAULT NULL COMMENT '所属終了日',
  `remarks` text COLLATE utf8mb4_general_ci COMMENT '備考',
  `browsing_authority` tinyint NOT NULL COMMENT '他の保育所閲覧権限 0：なし 1：あり',
  `shift_display` tinyint NOT NULL DEFAULT '1' COMMENT 'シフト画面での表示設定 0：表示しない 1：表示する',
  `daily_work_display` tinyint NOT NULL DEFAULT '1' COMMENT 'デイリーワーク画面での表示設定 0：表示しない 1：表示する',
  `attendance_display` tinyint NOT NULL DEFAULT '1' COMMENT '勤怠管理画面での表示設定 0：表示しない 1：表示する',
  `overtime_calc_type` tinyint NOT NULL DEFAULT '1' COMMENT '時間外算出パターン 1:固定時間制 2:変形時間制',
  `worktime_hr` int DEFAULT '8' COMMENT '固定時間制の場合の勤務時間(時間)',
  `worktime_min` int DEFAULT NULL COMMENT '固定時間制の場合の勤務時間(分)',
  `attendance_engagement_category` tinyint NOT NULL DEFAULT '1' COMMENT '出退勤登録の従事区分:1:保育従事2:その他',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- テーブルの構造 `b_employee_department_histories`
--

CREATE TABLE `b_employee_department_histories` (
  `history_id` bigint UNSIGNED NOT NULL COMMENT '履歴ID',
  `employee_id` int UNSIGNED NOT NULL COMMENT '従業員ID',
  `nursery_id` int UNSIGNED NOT NULL COMMENT '保育所ID',
  `belong_from` date NOT NULL COMMENT '所属開始日',
  `belong_to` date DEFAULT NULL COMMENT '所属終了日',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- テーブルの構造 `b_employee_qualifications`
--

CREATE TABLE `b_employee_qualifications` (
  `employee_qualification_id` int UNSIGNED NOT NULL COMMENT '紐付ID',
  `employee_id` int NOT NULL COMMENT '従業員ID',
  `qualification_id` tinyint NOT NULL COMMENT '資格ID',
  `get_date` date NOT NULL DEFAULT '2016-01-01' COMMENT '資格取得日',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- テーブルの構造 `b_employee_working_form_histories`
--

CREATE TABLE `b_employee_working_form_histories` (
  `history_id` bigint UNSIGNED NOT NULL COMMENT '履歴ID',
  `employee_id` int NOT NULL COMMENT '従業員ID',
  `working_form_category` tinyint NOT NULL COMMENT '常勤非常勤区分',
  `working_form_start` date NOT NULL COMMENT '開始日',
  `working_form_end` date DEFAULT NULL COMMENT '終了日',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- テーブルの構造 `b_events`
--

CREATE TABLE `b_events` (
  `event_id` int UNSIGNED NOT NULL COMMENT 'イベントID',
  `nursery_id` int NOT NULL COMMENT '保育所ID',
  `class_id` int DEFAULT NULL COMMENT 'クラス',
  `target_date` date NOT NULL COMMENT '対象日',
  `event_name` varchar(255) COLLATE utf8mb4_general_ci NOT NULL COMMENT '値',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- テーブルの構造 `b_extention_charge_invoice_settings`
--

CREATE TABLE `b_extention_charge_invoice_settings` (
  `nursery_id` int NOT NULL COMMENT '保育所ID',
  `invoice_info` int NOT NULL COMMENT '請求先指定',
  `bank_name` varchar(255) COLLATE utf8mb4_general_ci NOT NULL COMMENT '金融機関名',
  `branch_name` varchar(255) COLLATE utf8mb4_general_ci NOT NULL COMMENT '支店名',
  `account_type` varchar(255) COLLATE utf8mb4_general_ci NOT NULL COMMENT '口座種別',
  `account_number` varchar(7) COLLATE utf8mb4_general_ci NOT NULL COMMENT '口座番号',
  `account_name` varchar(255) COLLATE utf8mb4_general_ci NOT NULL COMMENT '口座名義',
  `tax_type` int NOT NULL COMMENT '延長保育料の税種別',
  `tax_rate` int NOT NULL COMMENT '税率',
  `calculation_method` tinyint NOT NULL DEFAULT '0' COMMENT '延長料金計算方式',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- テーブルの構造 `b_extention_charge_price_contract_settings`
--

CREATE TABLE `b_extention_charge_price_contract_settings` (
  `price_id` bigint UNSIGNED NOT NULL COMMENT '延長料金ID',
  `nursery_id` int NOT NULL COMMENT '保育所ID',
  `category_id` int NOT NULL COMMENT 'カテゴリ',
  `time_unit` int NOT NULL COMMENT '単位（〇分毎）',
  `fraction` int NOT NULL COMMENT '端数（切上げ／切捨て）',
  `price_zero_year_old` int DEFAULT NULL COMMENT '値段（0歳児）',
  `price_one_year_old` int DEFAULT NULL COMMENT '値段（1歳児）',
  `price_two_years_old` int DEFAULT NULL COMMENT '値段（2歳児）',
  `price_three_years_old` int DEFAULT NULL COMMENT '値段（3歳児）',
  `price_four_years_old` int DEFAULT NULL COMMENT '値段（4歳児）',
  `price_five_years_old` int DEFAULT NULL COMMENT '値段（5歳児）',
  `border` int NOT NULL COMMENT '境界',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- テーブルの構造 `b_extention_charge_price_settings`
--

CREATE TABLE `b_extention_charge_price_settings` (
  `price_id` bigint UNSIGNED NOT NULL COMMENT '延長料金ID',
  `nursery_id` int NOT NULL COMMENT '保育所ID',
  `category_id` int NOT NULL COMMENT 'カテゴリ',
  `time_unit` int NOT NULL COMMENT '単位（〇分毎）',
  `fraction` int NOT NULL COMMENT '端数（切上げ／切捨て）',
  `price_zero_year_old` int DEFAULT NULL COMMENT '値段（0歳児）',
  `price_one_year_old` int DEFAULT NULL COMMENT '値段（1歳児）',
  `price_two_years_old` int DEFAULT NULL COMMENT '値段（2歳児）',
  `price_three_years_old` int DEFAULT NULL COMMENT '値段（3歳児）',
  `price_four_years_old` int DEFAULT NULL COMMENT '値段（4歳児）',
  `price_five_years_old` int DEFAULT NULL COMMENT '値段（5歳児）',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- テーブルの構造 `b_extention_charge_time_contract_settings`
--

CREATE TABLE `b_extention_charge_time_contract_settings` (
  `charge_id` bigint UNSIGNED NOT NULL COMMENT '延長料金ID',
  `nursery_id` int NOT NULL COMMENT '保育所ID',
  `category_id` int NOT NULL COMMENT 'カテゴリ',
  `start_time` time DEFAULT NULL COMMENT '開始時間',
  `end_time` time DEFAULT NULL COMMENT '終了時間',
  `nurture_amount` int NOT NULL COMMENT '保育必要量',
  `availability` int NOT NULL COMMENT '使用可否',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- テーブルの構造 `b_extention_charge_time_settings`
--

CREATE TABLE `b_extention_charge_time_settings` (
  `charge_id` bigint UNSIGNED NOT NULL COMMENT '延長料金ID',
  `nursery_id` int NOT NULL COMMENT '保育所ID',
  `category_id` int NOT NULL COMMENT 'カテゴリ',
  `start_time` time DEFAULT NULL COMMENT '開始時間',
  `end_time` time DEFAULT NULL COMMENT '終了時間',
  `nurture_amount` int NOT NULL COMMENT '保育必要量',
  `availability` int NOT NULL COMMENT '使用可否',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- テーブルの構造 `b_families`
--

CREATE TABLE `b_families` (
  `family_id` int UNSIGNED NOT NULL COMMENT '家族ID',
  `child_id` int NOT NULL COMMENT '児童ID',
  `relationship` tinyint NOT NULL COMMENT '続柄',
  `last_name` varchar(50) COLLATE utf8mb4_general_ci NOT NULL COMMENT '姓',
  `first_name` varchar(50) COLLATE utf8mb4_general_ci NOT NULL COMMENT '名',
  `last_name_kana` varchar(50) COLLATE utf8mb4_general_ci NOT NULL COMMENT '姓(カナ)',
  `first_name_kana` varchar(50) COLLATE utf8mb4_general_ci NOT NULL COMMENT '名(カナ)',
  `cell_phone` varchar(14) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '携帯電話番号',
  `tel` varchar(14) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '自宅電話番号',
  `emergency_contact` varchar(14) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '緊急連絡先',
  `mail` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT 'メールアドレス',
  `office` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '勤務先',
  `business_tel` varchar(14) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '勤務先 電話番号',
  `business_prefecture_id` tinyint DEFAULT NULL COMMENT '勤務先 都道府県ID',
  `business_address1` varchar(40) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '勤務先 住所1',
  `business_address2` varchar(40) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '勤務先 住所2',
  `weekday_working_hours` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '平日勤務',
  `saturday_working_hours` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '土曜勤務',
  `shiftwork` tinyint(1) DEFAULT NULL COMMENT '交代勤務 0：なし 1：あり',
  `paid_holiday` tinyint(1) DEFAULT NULL COMMENT '有給休暇 0：なし 1：あり',
  `transportation_to_nursery` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '保育所への移動手段',
  `travel_time_to_nursery` int DEFAULT NULL COMMENT '保育所への移動時間(分)',
  `transportation_to_office` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '勤務先への移動手段',
  `travel_time_to_office` int DEFAULT NULL COMMENT '勤務先への移動時間(分)',
  `image_path` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '画像パス',
  `remarks` text COLLATE utf8mb4_general_ci COMMENT '備考',
  `token` varchar(255) COLLATE utf8mb4_general_ci NOT NULL COMMENT 'トークン',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- テーブルの構造 `b_fixed_phrases`
--

CREATE TABLE `b_fixed_phrases` (
  `phrase_id` int UNSIGNED NOT NULL COMMENT '管理ID',
  `category` varchar(255) COLLATE utf8mb4_general_ci NOT NULL COMMENT '区分',
  `phrase` text COLLATE utf8mb4_general_ci NOT NULL COMMENT '定型文',
  `order` int DEFAULT NULL COMMENT '表示順',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- テーブルの構造 `b_hourly_aggregation_configs`
--

CREATE TABLE `b_hourly_aggregation_configs` (
  `id` bigint UNSIGNED NOT NULL COMMENT 'ID',
  `nursery_id` int NOT NULL COMMENT '保育所ID',
  `aggregation_time` time NOT NULL COMMENT '集計時刻',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- テーブルの構造 `b_ip_address_permissions`
--

CREATE TABLE `b_ip_address_permissions` (
  `id` bigint UNSIGNED NOT NULL COMMENT '連番',
  `ip_address` varchar(15) COLLATE utf8mb4_general_ci NOT NULL COMMENT 'IPアドレスv4',
  `mask` tinyint DEFAULT NULL COMMENT 'サブネットマスク(ビット数)',
  `memo` varchar(30) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT 'メモ',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- テーブルの構造 `b_item_configs`
--

CREATE TABLE `b_item_configs` (
  `config_id` bigint UNSIGNED NOT NULL COMMENT '設定ID',
  `user_id` int NOT NULL COMMENT 'ユーザID',
  `category` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT 'カテゴリ',
  `item_name` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '項目名',
  `item_value` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '項目値',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- テーブルの構造 `b_meal_inspection_record_items`
--

CREATE TABLE `b_meal_inspection_record_items` (
  `item_id` bigint UNSIGNED NOT NULL COMMENT '入力項目ID',
  `nursery_id` int NOT NULL COMMENT '保育所ID',
  `item_name` varchar(255) COLLATE utf8mb4_general_ci NOT NULL COMMENT '入力項目名',
  `input_type` int NOT NULL COMMENT '入力種別',
  `value` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '選択肢',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- テーブルの構造 `b_meal_inspection_record_item_regist_categories`
--

CREATE TABLE `b_meal_inspection_record_item_regist_categories` (
  `classify_id` bigint UNSIGNED NOT NULL COMMENT '分類ID',
  `nursery_id` int NOT NULL COMMENT '保育所ID',
  `item_id` int NOT NULL COMMENT '入力項目ID',
  `sort` int DEFAULT NULL COMMENT '表示順',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- テーブルの構造 `b_meal_inspection_record_meal_categories`
--

CREATE TABLE `b_meal_inspection_record_meal_categories` (
  `item_id` bigint UNSIGNED NOT NULL COMMENT '食事種別ID',
  `item_name` varchar(255) COLLATE utf8mb4_general_ci NOT NULL COMMENT '食事種別名',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- テーブルの構造 `b_meal_inspection_record_meal_category_regist_categories`
--

CREATE TABLE `b_meal_inspection_record_meal_category_regist_categories` (
  `classify_id` bigint UNSIGNED NOT NULL COMMENT '分類ID',
  `nursery_id` int NOT NULL COMMENT '保育所ID',
  `item_id` int NOT NULL COMMENT '食事種別ID',
  `sort` int DEFAULT NULL COMMENT '表示順',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- テーブルの構造 `b_monthly_plan_items`
--

CREATE TABLE `b_monthly_plan_items` (
  `item_id` int UNSIGNED NOT NULL COMMENT '項目ID',
  `item_name` varchar(255) COLLATE utf8mb4_general_ci NOT NULL COMMENT '項目名',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- テーブルの構造 `b_monthly_plan_regist_categories`
--

CREATE TABLE `b_monthly_plan_regist_categories` (
  `classify_id` bigint UNSIGNED NOT NULL COMMENT '分類ID',
  `nursery_id` int NOT NULL COMMENT '保育所ID',
  `class_id` int NOT NULL COMMENT 'クラスID',
  `item_id` int NOT NULL COMMENT 'アイテムID',
  `sort` tinyint DEFAULT NULL COMMENT '表示順',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- テーブルの構造 `b_near_hit_items`
--

CREATE TABLE `b_near_hit_items` (
  `item_id` bigint UNSIGNED NOT NULL COMMENT '項目ID',
  `item_name` varchar(255) COLLATE utf8mb4_general_ci NOT NULL COMMENT '項目名',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- テーブルの構造 `b_near_hit_regist_categories`
--

CREATE TABLE `b_near_hit_regist_categories` (
  `classify_id` bigint UNSIGNED NOT NULL COMMENT '分類ID',
  `nursery_id` int NOT NULL COMMENT '保育所ID',
  `item_id` int NOT NULL COMMENT 'アイテムID',
  `sort` int DEFAULT NULL COMMENT '表示順',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- テーブルの構造 `b_nurseries`
--

CREATE TABLE `b_nurseries` (
  `nursery_id` int UNSIGNED NOT NULL COMMENT '保育所ID',
  `nursery_name` varchar(255) COLLATE utf8mb4_general_ci NOT NULL COMMENT '保育所名',
  `postal_code` varchar(7) COLLATE utf8mb4_general_ci NOT NULL COMMENT '郵便番号',
  `prefecture_id` tinyint NOT NULL COMMENT '都道府県ID',
  `address1` varchar(40) COLLATE utf8mb4_general_ci NOT NULL COMMENT '住所1',
  `address2` varchar(40) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '住所2',
  `tel` varchar(14) COLLATE utf8mb4_general_ci NOT NULL COMMENT '電話番号',
  `fax` varchar(14) COLLATE utf8mb4_general_ci NOT NULL COMMENT 'FAX番号',
  `mail` varchar(255) COLLATE utf8mb4_general_ci NOT NULL COMMENT 'メールアドレス',
  `representative_last_name` varchar(50) COLLATE utf8mb4_general_ci NOT NULL COMMENT '施設代表者 姓',
  `representative_first_name` varchar(50) COLLATE utf8mb4_general_ci NOT NULL COMMENT '施設代表者 名',
  `representative_last_name_kana` varchar(50) COLLATE utf8mb4_general_ci NOT NULL COMMENT '施設代表者 姓(カナ)',
  `representative_first_name_kana` varchar(50) COLLATE utf8mb4_general_ci NOT NULL COMMENT '施設代表者 名(カナ)',
  `remarks` text COLLATE utf8mb4_general_ci COMMENT '備考',
  `era_pattern` tinyint NOT NULL DEFAULT '1' COMMENT '年号表示種別:1:パターン1 2:パターン2 3:パターン3',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- テーブルの構造 `b_nursery_bank_accounts`
--

CREATE TABLE `b_nursery_bank_accounts` (
  `account_id` bigint UNSIGNED NOT NULL COMMENT '口座ID',
  `nursery_id` int NOT NULL COMMENT '保育所ID',
  `display_name` varchar(255) COLLATE utf8mb4_general_ci NOT NULL COMMENT '表示名',
  `bank_name` varchar(255) COLLATE utf8mb4_general_ci NOT NULL COMMENT '金融機関名',
  `branch_name` varchar(255) COLLATE utf8mb4_general_ci NOT NULL COMMENT '支店名',
  `account_type` varchar(255) COLLATE utf8mb4_general_ci NOT NULL COMMENT '口座種別',
  `account_number` varchar(7) COLLATE utf8mb4_general_ci NOT NULL COMMENT '口座番号',
  `account_name` varchar(255) COLLATE utf8mb4_general_ci NOT NULL COMMENT '口座名義',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- テーブルの構造 `b_nursery_goods`
--

CREATE TABLE `b_nursery_goods` (
  `goods_id` bigint UNSIGNED NOT NULL COMMENT '物品ID',
  `nursery_id` int NOT NULL COMMENT '保育所ID',
  `goods_name` varchar(255) COLLATE utf8mb4_general_ci NOT NULL COMMENT '物品名',
  `price` int NOT NULL COMMENT '単価',
  `tax_type` int NOT NULL COMMENT '税種別',
  `sort` int NOT NULL COMMENT 'ソート順',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- テーブルの構造 `b_nursery_histories`
--

CREATE TABLE `b_nursery_histories` (
  `history_id` bigint UNSIGNED NOT NULL COMMENT '履歴ID',
  `nursery_category` tinyint NOT NULL COMMENT '保育所区分',
  `staffing_percentage` int DEFAULT NULL COMMENT '人員配置割合',
  `nursery_id` int NOT NULL COMMENT '保育所ID',
  `auth_start_date` date NOT NULL COMMENT '開始日',
  `auth_end_date` date DEFAULT NULL COMMENT '終了日',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- テーブルの構造 `b_nursery_monthly_fees`
--

CREATE TABLE `b_nursery_monthly_fees` (
  `fee_id` bigint UNSIGNED NOT NULL COMMENT '月極金額ID',
  `nursery_id` int NOT NULL COMMENT '保育所ID',
  `fee_name` varchar(255) COLLATE utf8mb4_general_ci NOT NULL COMMENT '月極金額名',
  `tax_type` int NOT NULL COMMENT '税種別',
  `sort` int NOT NULL COMMENT 'ソート順',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- テーブルの構造 `b_nurture_diary_items`
--

CREATE TABLE `b_nurture_diary_items` (
  `item_id` int UNSIGNED NOT NULL COMMENT '項目ID',
  `item_name` varchar(255) COLLATE utf8mb4_general_ci NOT NULL COMMENT '項目名',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- テーブルの構造 `b_nurture_diary_regist_categories`
--

CREATE TABLE `b_nurture_diary_regist_categories` (
  `classify_id` bigint UNSIGNED NOT NULL COMMENT '分類ID',
  `nursery_id` int NOT NULL COMMENT '保育所ID',
  `class_id` int NOT NULL COMMENT 'クラスID',
  `item_id` int NOT NULL COMMENT 'アイテムID',
  `sort` tinyint DEFAULT NULL COMMENT '表示順',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- テーブルの構造 `b_optional_item_items`
--

CREATE TABLE `b_optional_item_items` (
  `item_id` bigint UNSIGNED NOT NULL COMMENT '項目ID',
  `item_name` varchar(255) COLLATE utf8mb4_general_ci NOT NULL COMMENT '項目名',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- テーブルの構造 `b_optional_item_regist_categories`
--

CREATE TABLE `b_optional_item_regist_categories` (
  `manage_id` bigint UNSIGNED NOT NULL COMMENT '管理ID',
  `nursery_id` int NOT NULL COMMENT '保育所ID',
  `item_id` bigint NOT NULL COMMENT '項目ID',
  `sort` int DEFAULT NULL COMMENT '表示順',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- テーブルの構造 `b_personal_items`
--

CREATE TABLE `b_personal_items` (
  `item_id` int UNSIGNED NOT NULL COMMENT '項目ID',
  `item_name` varchar(255) COLLATE utf8mb4_general_ci NOT NULL COMMENT '項目名',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- テーブルの構造 `b_personal_regist_categories`
--

CREATE TABLE `b_personal_regist_categories` (
  `classify_id` bigint UNSIGNED NOT NULL COMMENT '分類ID',
  `nursery_id` int NOT NULL COMMENT '保育所ID',
  `class_id` int NOT NULL COMMENT 'クラスID',
  `item_id` int NOT NULL COMMENT 'アイテムID',
  `sort` tinyint DEFAULT NULL COMMENT '表示順',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- テーブルの構造 `b_personal_shift_templates`
--

CREATE TABLE `b_personal_shift_templates` (
  `personal_shift_id` int UNSIGNED NOT NULL COMMENT '個人シフトID',
  `employees_id` int NOT NULL COMMENT '社員ID',
  `week_day` tinyint NOT NULL COMMENT '曜日',
  `shift_id` int DEFAULT NULL COMMENT 'シフト管理ID',
  `attendance_time` time NOT NULL COMMENT '登園時間',
  `leaving_time` time NOT NULL COMMENT '降園時間',
  `break_time` time NOT NULL COMMENT '休憩時間',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- テーブルの構造 `b_shift_templates`
--

CREATE TABLE `b_shift_templates` (
  `shift_id` int UNSIGNED NOT NULL COMMENT 'シフト管理ID',
  `nursery_id` int NOT NULL COMMENT '保育所ID',
  `shift_name` varchar(10) COLLATE utf8mb4_general_ci NOT NULL COMMENT 'シフト名',
  `shift_color` varchar(10) COLLATE utf8mb4_general_ci NOT NULL COMMENT '色',
  `attendance_time` time NOT NULL COMMENT '登園時間',
  `leaving_time` time NOT NULL COMMENT '降園時間',
  `break_time` time NOT NULL COMMENT '休憩時間',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- テーブルの構造 `b_staffings`
--

CREATE TABLE `b_staffings` (
  `staffing_id` int UNSIGNED NOT NULL COMMENT '人員配置ID',
  `nursery_id` int NOT NULL COMMENT '保育所ID',
  `child_age_zero` int NOT NULL COMMENT '児童人数（0歳）',
  `nursery_teachers_zero` int NOT NULL COMMENT '保育士人数（0歳）',
  `decimal_point_flg_zero` tinyint NOT NULL COMMENT '少数点フラグ（0歳）',
  `scale_flg_zero` tinyint NOT NULL COMMENT 'スケールフラグ（0歳）',
  `child_age_one` int NOT NULL COMMENT '児童人数（1歳）',
  `nursery_teachers_one` int NOT NULL COMMENT '保育士人数（1歳）',
  `decimal_point_flg_one` tinyint NOT NULL COMMENT '少数点フラグ（1歳）',
  `scale_flg_one` tinyint NOT NULL COMMENT 'スケールフラグ（1歳）',
  `child_age_two` int NOT NULL COMMENT '児童人数（2歳）',
  `nursery_teachers_two` int NOT NULL COMMENT '保育士人数（2歳）',
  `decimal_point_flg_two` tinyint NOT NULL COMMENT '少数点フラグ（2歳）',
  `scale_flg_two` tinyint NOT NULL COMMENT 'スケールフラグ（2歳）',
  `child_age_three` int NOT NULL COMMENT '児童人数（3歳）',
  `nursery_teachers_three` int NOT NULL COMMENT '保育士人数（3歳）',
  `decimal_point_flg_three` tinyint NOT NULL COMMENT '少数点フラグ（3歳）',
  `scale_flg_three` tinyint NOT NULL COMMENT 'スケールフラグ（3歳）',
  `child_age_four` int NOT NULL COMMENT '児童人数（4歳）',
  `nursery_teachers_four` int NOT NULL COMMENT '保育士人数（4歳）',
  `decimal_point_flg_four` tinyint NOT NULL COMMENT '少数点フラグ（4歳）',
  `scale_flg_four` tinyint NOT NULL COMMENT 'スケールフラグ（4歳）',
  `child_age_five` int NOT NULL COMMENT '児童人数（5歳）',
  `nursery_teachers_five` int NOT NULL COMMENT '保育士人数（5歳）',
  `decimal_point_flg_five` tinyint NOT NULL COMMENT '少数点フラグ（5歳）',
  `scale_flg_five` tinyint NOT NULL COMMENT 'スケールフラグ（5歳）',
  `result_scale_flg` tinyint NOT NULL COMMENT '算出結果スケールフラグ',
  `kahai` tinyint NOT NULL COMMENT '加配人数',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- テーブルの構造 `b_term_items`
--

CREATE TABLE `b_term_items` (
  `item_id` bigint UNSIGNED NOT NULL COMMENT 'マスタ項目ID',
  `term` tinyint NOT NULL COMMENT '期ID',
  `from` tinyint NOT NULL COMMENT '開始月',
  `to` tinyint NOT NULL COMMENT '終了月',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- テーブルの構造 `b_term_regist_categories`
--

CREATE TABLE `b_term_regist_categories` (
  `classify_id` bigint UNSIGNED NOT NULL COMMENT '分類ID',
  `nursery_id` int NOT NULL COMMENT '保育所ID',
  `class_id` int NOT NULL COMMENT 'クラスID',
  `item_id` int NOT NULL COMMENT 'アイテムID',
  `sort` tinyint DEFAULT NULL COMMENT '表示順',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- テーブルの構造 `b_tokens`
--

CREATE TABLE `b_tokens` (
  `uniq_id` bigint UNSIGNED NOT NULL COMMENT '連番',
  `access_token` varchar(60) COLLATE utf8mb4_general_ci NOT NULL COMMENT 'アクセストークン',
  `token_type` varchar(16) COLLATE utf8mb4_general_ci NOT NULL COMMENT 'トークン種別',
  `expires_in` int NOT NULL COMMENT '有効期間',
  `scope` varchar(128) COLLATE utf8mb4_general_ci NOT NULL COMMENT 'スコープ',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- テーブルの構造 `b_users`
--

CREATE TABLE `b_users` (
  `user_id` int UNSIGNED NOT NULL COMMENT 'ユーザーID',
  `login_id` varchar(32) COLLATE utf8mb4_general_ci NOT NULL COMMENT 'ログインID',
  `password` varchar(255) COLLATE utf8mb4_general_ci NOT NULL COMMENT 'パスワード',
  `employee_id` int NOT NULL COMMENT '従業員ID',
  `token` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT 'トークン',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- テーブルの構造 `b_user_auths`
--

CREATE TABLE `b_user_auths` (
  `user_auth_id` int UNSIGNED NOT NULL COMMENT '紐付ID',
  `user_id` int NOT NULL COMMENT 'ユーザーID',
  `auth_id` tinyint NOT NULL COMMENT '権限ID',
  `auth_level` tinyint NOT NULL COMMENT '権限種別 0：なし 1：閲覧 2：編集',
  `viewing_permission` tinyint NOT NULL DEFAULT '0' COMMENT '閲覧制限',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- テーブルの構造 `b_weather_items`
--

CREATE TABLE `b_weather_items` (
  `weather_item_id` int UNSIGNED NOT NULL COMMENT '項目ID',
  `item_name` varchar(255) COLLATE utf8mb4_general_ci NOT NULL COMMENT '項目名',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- テーブルの構造 `b_weekly_plan_items`
--

CREATE TABLE `b_weekly_plan_items` (
  `item_id` int UNSIGNED NOT NULL COMMENT '項目ID',
  `item_name` varchar(255) COLLATE utf8mb4_general_ci NOT NULL COMMENT '項目名',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- テーブルの構造 `b_weekly_plan_regist_categories`
--

CREATE TABLE `b_weekly_plan_regist_categories` (
  `classify_id` bigint UNSIGNED NOT NULL COMMENT '分類ID',
  `nursery_id` int NOT NULL COMMENT '保育所ID',
  `class_id` int NOT NULL COMMENT 'クラスID',
  `item_id` int NOT NULL COMMENT 'アイテムID',
  `sort` tinyint DEFAULT NULL COMMENT '表示順',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- テーブルの構造 `b_yearly_plan_items`
--

CREATE TABLE `b_yearly_plan_items` (
  `item_id` int UNSIGNED NOT NULL COMMENT '項目ID',
  `item_name` varchar(255) COLLATE utf8mb4_general_ci NOT NULL COMMENT '項目名',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- テーブルの構造 `b_yearly_plan_regist_categories`
--

CREATE TABLE `b_yearly_plan_regist_categories` (
  `classify_id` bigint UNSIGNED NOT NULL COMMENT '分類ID',
  `nursery_id` int NOT NULL COMMENT '保育所ID',
  `class_id` int NOT NULL COMMENT 'クラスID',
  `item_id` int NOT NULL COMMENT 'アイテムID',
  `sort` tinyint DEFAULT NULL COMMENT '表示順',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- テーブルの構造 `child_attendances`
--

CREATE TABLE `child_attendances` (
  `id` int UNSIGNED NOT NULL,
  `school_day` date NOT NULL COMMENT '出欠連絡の対象日',
  `child_id` int UNSIGNED NOT NULL COMMENT '児童ID',
  `changed_time` time DEFAULT NULL COMMENT '変更された登園/降園予定時刻',
  `text` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '出欠連絡メッセージ本文',
  `absence_type` int DEFAULT NULL COMMENT '欠席タイプ 1 病欠 2 都合欠',
  `diseases` json DEFAULT NULL COMMENT '病名症状タグid 配列',
  `attendance_status_id` int UNSIGNED NOT NULL COMMENT '出欠ステータスID',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- テーブルの構造 `child_attendance_requests`
--

CREATE TABLE `child_attendance_requests` (
  `id` bigint UNSIGNED NOT NULL,
  `nursery_id` bigint UNSIGNED DEFAULT NULL,
  `class_id` bigint UNSIGNED DEFAULT NULL,
  `child_id` int UNSIGNED NOT NULL COMMENT '児童ID',
  `attendance_status_id` int UNSIGNED NOT NULL COMMENT '出欠ステータスID',
  `target_day` date NOT NULL COMMENT '対象日',
  `attendance_time` time DEFAULT NULL COMMENT '変更後登園予定時刻',
  `leaving_time` time DEFAULT NULL COMMENT '変更後降園予定時刻',
  `message` text COLLATE utf8mb4_general_ci COMMENT '連絡メッセージ本文',
  `absence_type` int DEFAULT NULL COMMENT '欠席タイプ 1 病欠 2 都合欠',
  `diseases` json DEFAULT NULL COMMENT '病名症状タグid 配列',
  `read_employee_id` int UNSIGNED DEFAULT NULL COMMENT '既読にした従業員ID',
  `read_at` timestamp NULL DEFAULT NULL COMMENT '既読にしたタイムスタンプ',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- テーブルの構造 `child_attendance_statuses`
--

CREATE TABLE `child_attendance_statuses` (
  `id` int UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_general_ci NOT NULL COMMENT '出欠ステータス',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- テーブルの構造 `child_notice`
--

CREATE TABLE `child_notice` (
  `id` int UNSIGNED NOT NULL,
  `notice_id` int UNSIGNED NOT NULL COMMENT 'お知らせID',
  `child_id` int UNSIGNED NOT NULL COMMENT '公開先の児童ID',
  `read_at` timestamp NULL DEFAULT NULL COMMENT '既読日時',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- テーブルの構造 `class_notice`
--

CREATE TABLE `class_notice` (
  `id` int UNSIGNED NOT NULL,
  `notice_id` int UNSIGNED NOT NULL COMMENT 'お知らせID',
  `class_id` int UNSIGNED NOT NULL COMMENT 'クラスID',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- テーブルの構造 `communication_board_attached_files`
--

CREATE TABLE `communication_board_attached_files` (
  `id` int UNSIGNED NOT NULL,
  `t_communication_board_id` bigint UNSIGNED NOT NULL COMMENT '投稿ID',
  `s3_file_name` varchar(255) COLLATE utf8mb4_general_ci NOT NULL COMMENT 'S3に保存されたファイル名',
  `original_file_name` varchar(255) COLLATE utf8mb4_general_ci NOT NULL COMMENT '表示ファイル名',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- テーブルの構造 `defecation_categories`
--

CREATE TABLE `defecation_categories` (
  `id` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_general_ci NOT NULL COMMENT '排泄方法名'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- テーブルの構造 `defecation_statuses`
--

CREATE TABLE `defecation_statuses` (
  `id` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_general_ci NOT NULL COMMENT '排泄状態名'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- テーブルの構造 `diseases`
--

CREATE TABLE `diseases` (
  `id` bigint UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_general_ci NOT NULL COMMENT '病名または症状名',
  `type` enum('symptom','disease') COLLATE utf8mb4_general_ci NOT NULL COMMENT 'symptom 症状 disease 病名',
  `sort` int NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- テーブルの構造 `employee_broadcast_messages`
--

CREATE TABLE `employee_broadcast_messages` (
  `id` int UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `nurture_diary_id` int UNSIGNED NOT NULL,
  `text` text COLLATE utf8mb4_general_ci NOT NULL COMMENT '本文'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- テーブルの構造 `employee_messages`
--

CREATE TABLE `employee_messages` (
  `id` int UNSIGNED NOT NULL,
  `employee_id` int UNSIGNED NOT NULL COMMENT '従業員ID',
  `message_status_id` int UNSIGNED NOT NULL COMMENT 'メッセージのステータスID',
  `text` text COLLATE utf8mb4_general_ci COMMENT '本文',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `school_meal` text COLLATE utf8mb4_general_ci,
  `note_contact_id` int UNSIGNED DEFAULT NULL COMMENT '対象の連絡ID',
  `memo` text COLLATE utf8mb4_general_ci NOT NULL COMMENT '業務メモ',
  `diary_text` text COLLATE utf8mb4_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- テーブルの構造 `employee_message_images`
--

CREATE TABLE `employee_message_images` (
  `id` int UNSIGNED NOT NULL,
  `image_id` int UNSIGNED NOT NULL COMMENT '画像ID',
  `employee_message_id` int UNSIGNED NOT NULL COMMENT '従業員メッセージID',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- テーブルの構造 `employee_message_statuses`
--

CREATE TABLE `employee_message_statuses` (
  `id` int UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_general_ci NOT NULL COMMENT 'ステータス名',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- テーブルの構造 `employee_orders`
--

CREATE TABLE `employee_orders` (
  `id` int UNSIGNED NOT NULL,
  `employee_id` int NOT NULL COMMENT '従業員ID',
  `rank` int NOT NULL COMMENT '順位',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- テーブルの構造 `failed_jobs`
--

CREATE TABLE `failed_jobs` (
  `id` bigint UNSIGNED NOT NULL,
  `connection` text COLLATE utf8mb4_general_ci NOT NULL,
  `queue` text COLLATE utf8mb4_general_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_general_ci NOT NULL,
  `exception` longtext COLLATE utf8mb4_general_ci NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- テーブルの構造 `family_contacts`
--

CREATE TABLE `family_contacts` (
  `id` int UNSIGNED NOT NULL,
  `note_contact_id` int UNSIGNED NOT NULL COMMENT '対象の連絡ID',
  `is_sent` tinyint(1) NOT NULL DEFAULT '0' COMMENT '送信済みかどうか',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- テーブルの構造 `family_defecations`
--

CREATE TABLE `family_defecations` (
  `id` int UNSIGNED NOT NULL,
  `category_id` varchar(255) COLLATE utf8mb4_general_ci NOT NULL COMMENT '排泄方法ID',
  `status_id` varchar(255) COLLATE utf8mb4_general_ci NOT NULL COMMENT '排泄状態ID',
  `done_at` timestamp NOT NULL COMMENT '排泄日時',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `family_contact_id` int UNSIGNED DEFAULT NULL COMMENT '対象の家庭からの連絡'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- テーブルの構造 `family_meals`
--

CREATE TABLE `family_meals` (
  `id` int UNSIGNED NOT NULL,
  `category_id` varchar(255) COLLATE utf8mb4_general_ci NOT NULL COMMENT '食事の種類ID',
  `comment` text COLLATE utf8mb4_general_ci COMMENT '自由記入欄',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `family_contact_id` int UNSIGNED DEFAULT NULL COMMENT '対象の家庭からの連絡'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- テーブルの構造 `family_messages`
--

CREATE TABLE `family_messages` (
  `id` int UNSIGNED NOT NULL,
  `text` text COLLATE utf8mb4_general_ci NOT NULL COMMENT '本文',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `family_contact_id` int UNSIGNED DEFAULT NULL COMMENT '対象の家庭からの連絡'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- テーブルの構造 `family_sleeps`
--

CREATE TABLE `family_sleeps` (
  `id` int UNSIGNED NOT NULL,
  `started_at` timestamp NULL DEFAULT NULL COMMENT '就寝日時',
  `ended_at` timestamp NULL DEFAULT NULL COMMENT '起床日時',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `family_contact_id` int UNSIGNED DEFAULT NULL COMMENT '対象の家庭からの連絡'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- テーブルの構造 `family_thermometries`
--

CREATE TABLE `family_thermometries` (
  `id` int UNSIGNED NOT NULL,
  `temperature` double NOT NULL COMMENT '体温',
  `done_at` timestamp NOT NULL COMMENT '検温日時',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `family_contact_id` int UNSIGNED DEFAULT NULL COMMENT '対象の家庭からの連絡'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- テーブルの構造 `images`
--

CREATE TABLE `images` (
  `id` int UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_general_ci NOT NULL COMMENT 'ファイル名',
  `path` varchar(255) COLLATE utf8mb4_general_ci NOT NULL COMMENT 'ファイルパス',
  `width` int NOT NULL COMMENT '画像横サイズ(px)',
  `height` int NOT NULL COMMENT '画像縦サイズ(px)',
  `size` int DEFAULT NULL COMMENT '画像容量(byte)',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- テーブルの構造 `meal_categories`
--

CREATE TABLE `meal_categories` (
  `id` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_general_ci NOT NULL COMMENT '食事の種類名'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- テーブルの構造 `migrations`
--

CREATE TABLE `migrations` (
  `id` int UNSIGNED NOT NULL,
  `migration` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `batch` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- テーブルの構造 `m_allergy_categories`
--

CREATE TABLE `m_allergy_categories` (
  `category_id` int NOT NULL COMMENT '区分ID',
  `category_name` varchar(255) COLLATE utf8mb4_general_ci NOT NULL COMMENT '区分名',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- テーブルの構造 `m_allergy_items`
--

CREATE TABLE `m_allergy_items` (
  `item_id` int UNSIGNED NOT NULL COMMENT '項目ID',
  `item_name` varchar(255) COLLATE utf8mb4_general_ci NOT NULL COMMENT '項目名',
  `category_id` int NOT NULL COMMENT '区分ID',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- テーブルの構造 `m_auths`
--

CREATE TABLE `m_auths` (
  `auth_id` tinyint NOT NULL COMMENT '権限ID',
  `auth_name` varchar(30) COLLATE utf8mb4_general_ci NOT NULL COMMENT '権限名',
  `function_type` int NOT NULL COMMENT '機能タイプ　1：基本機能　2：全体管理機能',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- テーブルの構造 `m_employment_patterns`
--

CREATE TABLE `m_employment_patterns` (
  `employment_pattern_id` tinyint NOT NULL COMMENT '雇用形態ID',
  `employment_pattern_name` varchar(30) COLLATE utf8mb4_general_ci NOT NULL COMMENT '雇用形態名',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- テーブルの構造 `m_functions`
--

CREATE TABLE `m_functions` (
  `function_id` int UNSIGNED NOT NULL COMMENT '機能ID',
  `function_name` varchar(30) COLLATE utf8mb4_general_ci NOT NULL COMMENT '機能名',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- テーブルの構造 `m_function_auths`
--

CREATE TABLE `m_function_auths` (
  `function_auth_id` int UNSIGNED NOT NULL COMMENT '機能権限ID',
  `function_id` int NOT NULL COMMENT '機能ID',
  `auth_id` int NOT NULL COMMENT '権限ID',
  `auth_level` tinyint NOT NULL COMMENT '権限種別 0：なし 1：閲覧 2：編集',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- テーブルの構造 `m_health_items`
--

CREATE TABLE `m_health_items` (
  `item_id` int UNSIGNED NOT NULL COMMENT '項目ID',
  `item_name` varchar(255) COLLATE utf8mb4_general_ci NOT NULL COMMENT '項目名',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- テーブルの構造 `m_positions`
--

CREATE TABLE `m_positions` (
  `position_id` tinyint NOT NULL COMMENT '役職ID',
  `position_name` varchar(30) COLLATE utf8mb4_general_ci NOT NULL COMMENT '役職名',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- テーブルの構造 `m_prefectures`
--

CREATE TABLE `m_prefectures` (
  `prefecture_id` tinyint NOT NULL COMMENT '都道府県ID',
  `prefecture_name` varchar(15) COLLATE utf8mb4_general_ci NOT NULL COMMENT '都道府県名',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- テーブルの構造 `m_qualifications`
--

CREATE TABLE `m_qualifications` (
  `qualification_id` tinyint NOT NULL COMMENT '資格ID',
  `qualification_name` varchar(30) COLLATE utf8mb4_general_ci NOT NULL COMMENT '資格名',
  `qualification_category` tinyint NOT NULL COMMENT '資格区分',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- テーブルの構造 `note_contacts`
--

CREATE TABLE `note_contacts` (
  `id` int UNSIGNED NOT NULL,
  `contact_on` date NOT NULL COMMENT '連絡日',
  `child_id` int UNSIGNED NOT NULL COMMENT '対象の児童ID',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- テーブルの構造 `note_functions`
--

CREATE TABLE `note_functions` (
  `id` int UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `name` varchar(255) COLLATE utf8mb4_general_ci NOT NULL COMMENT '機能名',
  `optional` tinyint(1) NOT NULL DEFAULT '0' COMMENT '保育所ごとに任意の機能かどうか'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- テーブルの構造 `note_function_nursery`
--

CREATE TABLE `note_function_nursery` (
  `id` int UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `nursery_id` int UNSIGNED NOT NULL,
  `function_id` int UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- テーブルの構造 `note_main_users`
--

CREATE TABLE `note_main_users` (
  `id` int UNSIGNED NOT NULL,
  `child_id` int UNSIGNED NOT NULL COMMENT 'Noteメインユーザーを保護者に持つ児童ID',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- テーブルの構造 `note_nurture_schedule_changeable_days`
--

CREATE TABLE `note_nurture_schedule_changeable_days` (
  `id` int UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `nursery_id` int UNSIGNED NOT NULL,
  `due_date` int NOT NULL COMMENT '期限日'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- テーブルの構造 `notices`
--

CREATE TABLE `notices` (
  `id` int UNSIGNED NOT NULL,
  `released_at` datetime DEFAULT NULL COMMENT '公開日',
  `title` varchar(255) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT 'タイトル',
  `text` text COLLATE utf8mb4_general_ci NOT NULL COMMENT '本文',
  `author_id` int UNSIGNED NOT NULL COMMENT '作成者の従業員ID',
  `can_release` tinyint(1) NOT NULL COMMENT 'true:公開　false:下書き',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- テーブルの構造 `notice_attached_files`
--

CREATE TABLE `notice_attached_files` (
  `id` int UNSIGNED NOT NULL,
  `notice_id` int UNSIGNED NOT NULL COMMENT 'お知らせID',
  `path` varchar(255) COLLATE utf8mb4_general_ci NOT NULL COMMENT 'S3のパス',
  `name` varchar(255) COLLATE utf8mb4_general_ci NOT NULL COMMENT '表示ファイル名',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- テーブルの構造 `notice_questionnaire`
--

CREATE TABLE `notice_questionnaire` (
  `id` int UNSIGNED NOT NULL,
  `notice_id` int UNSIGNED NOT NULL COMMENT '対象のお知らせID',
  `questionnaire_id` int UNSIGNED NOT NULL COMMENT '対象のアンケートID',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- テーブルの構造 `nursery_features`
--

CREATE TABLE `nursery_features` (
  `id` int UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_general_ci NOT NULL COMMENT '機能名',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- テーブルの構造 `nursery_nursery_feature`
--

CREATE TABLE `nursery_nursery_feature` (
  `id` int UNSIGNED NOT NULL,
  `nursery_id` int UNSIGNED NOT NULL,
  `feature_id` int UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- テーブルの構造 `pool_attendances`
--

CREATE TABLE `pool_attendances` (
  `id` int UNSIGNED NOT NULL,
  `family_contact_id` int UNSIGNED NOT NULL,
  `is_participate` tinyint(1) NOT NULL COMMENT 'プールに参加するかどうか'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- テーブルの構造 `pool_terms`
--

CREATE TABLE `pool_terms` (
  `id` int UNSIGNED NOT NULL,
  `nursery_id` int UNSIGNED NOT NULL,
  `begin_on` date NOT NULL COMMENT '開催期間の開始日',
  `end_on` date NOT NULL COMMENT '開催期間の終了日',
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- テーブルの構造 `reserved_child_notices`
--

CREATE TABLE `reserved_child_notices` (
  `id` int UNSIGNED NOT NULL,
  `notice_id` int UNSIGNED NOT NULL COMMENT 'お知らせID',
  `child_id` int UNSIGNED NOT NULL COMMENT '公開先の児童ID',
  `nursery_id` int UNSIGNED NOT NULL COMMENT '園ID',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- テーブルの構造 `r_children`
--

CREATE TABLE `r_children` (
  `uniq_id` bigint UNSIGNED NOT NULL COMMENT '連番',
  `link_type` int NOT NULL COMMENT '連携タイプ',
  `link_id` int NOT NULL COMMENT '連携先ID',
  `child_id` int NOT NULL COMMENT '児童ID',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- テーブルの構造 `r_classes`
--

CREATE TABLE `r_classes` (
  `uniq_id` bigint UNSIGNED NOT NULL COMMENT '連番',
  `link_type` int NOT NULL COMMENT '連携タイプ',
  `link_id` int NOT NULL COMMENT '連携先ID',
  `class_id` int NOT NULL COMMENT 'クラスID',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- テーブルの構造 `r_companies`
--

CREATE TABLE `r_companies` (
  `uniq_id` bigint UNSIGNED NOT NULL COMMENT '連番',
  `link_type` int NOT NULL COMMENT '連携タイプ',
  `link_id` varchar(20) COLLATE utf8mb4_general_ci NOT NULL COMMENT '連携先ID',
  `company_id` varchar(20) COLLATE utf8mb4_general_ci NOT NULL COMMENT '企業ID',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- テーブルの構造 `r_employees`
--

CREATE TABLE `r_employees` (
  `uniq_id` bigint UNSIGNED NOT NULL COMMENT '連番',
  `link_type` int NOT NULL COMMENT '連携タイプ',
  `link_id` int NOT NULL COMMENT '連携先ID',
  `employee_id` int NOT NULL COMMENT '従業員ID',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- テーブルの構造 `r_families`
--

CREATE TABLE `r_families` (
  `uniq_id` bigint UNSIGNED NOT NULL COMMENT '連番',
  `link_type` int NOT NULL COMMENT '連携タイプ',
  `link_id` int NOT NULL COMMENT '連携先ID',
  `family_id` int NOT NULL COMMENT '家族ID',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- テーブルの構造 `r_nurseries`
--

CREATE TABLE `r_nurseries` (
  `uniq_id` bigint UNSIGNED NOT NULL COMMENT '連番',
  `link_type` int NOT NULL COMMENT '連携タイプ',
  `link_id` int NOT NULL COMMENT '連携先ID',
  `nursery_id` int NOT NULL COMMENT '保育所ID',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- テーブルの構造 `t_allergies`
--

CREATE TABLE `t_allergies` (
  `allergy_id` int UNSIGNED NOT NULL COMMENT 'アレルギーID',
  `child_id` int NOT NULL COMMENT '児童ID',
  `remarks` text COLLATE utf8mb4_general_ci COMMENT '備考',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- テーブルの構造 `t_allergy_manages`
--

CREATE TABLE `t_allergy_manages` (
  `manage_id` int UNSIGNED NOT NULL COMMENT '管理ID',
  `child_id` int NOT NULL COMMENT '児童ID',
  `item_id` int NOT NULL COMMENT '項目ID',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- テーブルの構造 `t_approved_business_logs`
--

CREATE TABLE `t_approved_business_logs` (
  `id` bigint UNSIGNED NOT NULL COMMENT '承認済み園日誌ID',
  `employee_id` int NOT NULL COMMENT '従業員ID',
  `log_id` int NOT NULL COMMENT '園日誌ID',
  `order` int NOT NULL COMMENT '承認順',
  `approved_at` timestamp NOT NULL COMMENT '承認日',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- テーブルの構造 `t_approved_daily_plans`
--

CREATE TABLE `t_approved_daily_plans` (
  `id` int UNSIGNED NOT NULL COMMENT '承認済み日案ID',
  `employee_id` int NOT NULL COMMENT '従業員ID',
  `plan_id` int NOT NULL COMMENT '日案ID',
  `order` int NOT NULL COMMENT '承認順',
  `approved_at` timestamp NOT NULL COMMENT '承認日',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- テーブルの構造 `t_approved_developmental_records`
--

CREATE TABLE `t_approved_developmental_records` (
  `id` bigint UNSIGNED NOT NULL COMMENT '承認済み発達記録ID',
  `employee_id` int NOT NULL COMMENT '従業員ID',
  `record_id` int NOT NULL COMMENT '発達記録ID',
  `order` int NOT NULL COMMENT '承認順',
  `approved_at` timestamp NOT NULL COMMENT '承認日',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- テーブルの構造 `t_approved_incident_reports`
--

CREATE TABLE `t_approved_incident_reports` (
  `id` bigint UNSIGNED NOT NULL COMMENT '承認済みヒヤリハット・事故報告書ID',
  `employee_id` int NOT NULL COMMENT '従業員ID',
  `incident_id` int NOT NULL COMMENT 'ヒヤリハット・事故報告書ID',
  `order` int NOT NULL COMMENT '承認順',
  `approved_at` timestamp NOT NULL COMMENT '承認日',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- テーブルの構造 `t_approved_meal_inspection_records`
--

CREATE TABLE `t_approved_meal_inspection_records` (
  `id` bigint UNSIGNED NOT NULL COMMENT '承認済み検食簿ID',
  `employee_id` int NOT NULL COMMENT '従業員ID',
  `record_id` int NOT NULL COMMENT '検食簿ID',
  `order` int NOT NULL COMMENT '承認順',
  `approved_at` timestamp NOT NULL COMMENT '承認日',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- テーブルの構造 `t_approved_monthly_plans`
--

CREATE TABLE `t_approved_monthly_plans` (
  `id` int UNSIGNED NOT NULL COMMENT '承認済み月案ID',
  `employee_id` int NOT NULL COMMENT '従業員ID',
  `plan_id` int NOT NULL COMMENT '月案ID',
  `order` int NOT NULL COMMENT '承認順',
  `approved_at` timestamp NOT NULL COMMENT '承認日',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- テーブルの構造 `t_approved_nurture_diaries`
--

CREATE TABLE `t_approved_nurture_diaries` (
  `id` int UNSIGNED NOT NULL COMMENT '承認済み保育日誌ID',
  `employee_id` int NOT NULL COMMENT '従業員ID',
  `diary_id` int NOT NULL COMMENT '保育日誌ID',
  `order` int NOT NULL COMMENT '承認順',
  `approved_at` timestamp NOT NULL COMMENT '承認日',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- テーブルの構造 `t_approved_personal_records`
--

CREATE TABLE `t_approved_personal_records` (
  `id` int UNSIGNED NOT NULL COMMENT '承認済み個人記録ID',
  `employee_id` int NOT NULL COMMENT '従業員ID',
  `personal_record_id` int NOT NULL COMMENT '個人記録ID',
  `order` int NOT NULL COMMENT '承認順',
  `approved_at` timestamp NOT NULL COMMENT '承認日',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- テーブルの構造 `t_approved_weekly_plans`
--

CREATE TABLE `t_approved_weekly_plans` (
  `id` int UNSIGNED NOT NULL COMMENT '承認済み週案ID',
  `employee_id` int NOT NULL COMMENT '従業員ID',
  `plan_id` int NOT NULL COMMENT '週案ID',
  `week` int NOT NULL COMMENT '週',
  `order` int NOT NULL COMMENT '承認順',
  `approved_at` timestamp NOT NULL COMMENT '承認日',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- テーブルの構造 `t_approved_yearly_plans`
--

CREATE TABLE `t_approved_yearly_plans` (
  `id` int UNSIGNED NOT NULL COMMENT '承認済み年間指導計画ID',
  `employee_id` int NOT NULL COMMENT '従業員ID',
  `plan_id` int NOT NULL COMMENT '年間指導計画ID',
  `order` int NOT NULL COMMENT '承認順',
  `approved_at` timestamp NOT NULL COMMENT '承認日',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- テーブルの構造 `t_attendances`
--

CREATE TABLE `t_attendances` (
  `attendance_id` int UNSIGNED NOT NULL COMMENT '勤怠管理ID',
  `employee_id` int NOT NULL COMMENT '従業員ID',
  `work_day` date NOT NULL COMMENT '年月日',
  `nursery_id` int DEFAULT NULL COMMENT '保育所ID',
  `clock_in_time` time DEFAULT NULL COMMENT '出勤時間',
  `clock_out_time` time DEFAULT NULL COMMENT '退勤時間',
  `break_time_start` time DEFAULT NULL COMMENT '休憩開始時刻',
  `break_time_end` time DEFAULT NULL COMMENT '休憩終了時刻',
  `break_time` time DEFAULT NULL COMMENT '休憩時間',
  `remarks` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '備考',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- テーブルの構造 `t_attendance_details`
--

CREATE TABLE `t_attendance_details` (
  `attendance_detail_id` bigint UNSIGNED NOT NULL,
  `attendance_id` bigint NOT NULL COMMENT '勤怠管理ID',
  `clock_in_time` time DEFAULT NULL COMMENT '出勤時間',
  `clock_out_time` time DEFAULT NULL COMMENT '退勤時間',
  `engagement_category` tinyint DEFAULT NULL COMMENT '従事区分:1:保育従事 2:その他',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- テーブルの構造 `t_body_measuring`
--

CREATE TABLE `t_body_measuring` (
  `body_measuring_id` int UNSIGNED NOT NULL COMMENT '身体測定ID',
  `child_id` int UNSIGNED NOT NULL COMMENT '児童ID',
  `date` date NOT NULL COMMENT '測定月',
  `measuring_date` date DEFAULT NULL COMMENT '測定日',
  `age` tinyint NOT NULL COMMENT '月齢',
  `height` decimal(8,2) DEFAULT NULL COMMENT '身長',
  `body_weight` decimal(8,2) DEFAULT NULL COMMENT '体重',
  `head_circumference` decimal(8,2) DEFAULT NULL COMMENT '頭囲',
  `chest_circumference` decimal(8,2) DEFAULT NULL COMMENT '胸囲',
  `remarks` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '備考',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- テーブルの構造 `t_business_logs`
--

CREATE TABLE `t_business_logs` (
  `log_id` int UNSIGNED NOT NULL COMMENT '園日誌ID',
  `nursery_id` int NOT NULL COMMENT '保育所ID',
  `target_date` date NOT NULL COMMENT '対象日',
  `temperature` decimal(4,1) DEFAULT NULL COMMENT '気温',
  `humidity` decimal(4,1) DEFAULT NULL COMMENT '湿度',
  `recorder` int NOT NULL COMMENT '記録者',
  `attendance_remarks` text COLLATE utf8mb4_general_ci COMMENT '出欠の特記事項',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- テーブルの構造 `t_business_log_manages`
--

CREATE TABLE `t_business_log_manages` (
  `manage_id` bigint UNSIGNED NOT NULL COMMENT '管理ID',
  `log_id` int NOT NULL COMMENT '保育日誌ID',
  `item_id` int NOT NULL COMMENT '項目ID',
  `sort` int DEFAULT NULL COMMENT '表示順',
  `value` text COLLATE utf8mb4_general_ci COMMENT '値',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- テーブルの構造 `t_child_attendances`
--

CREATE TABLE `t_child_attendances` (
  `child_attendance_id` bigint UNSIGNED NOT NULL COMMENT '登降園ID',
  `child_id` int NOT NULL COMMENT '児童ID',
  `school_day` date NOT NULL COMMENT '年月日',
  `attendance_time` time DEFAULT NULL COMMENT '登園時間',
  `leaving_time` time DEFAULT NULL COMMENT '降園時間',
  `scheduled_family_id` int DEFAULT NULL COMMENT 'お迎え予定家族ID',
  `family_id` int DEFAULT NULL COMMENT 'お迎え家族ID',
  `attendance_record` tinyint NOT NULL DEFAULT '0' COMMENT '出欠',
  `remarks` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '備考',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- テーブルの構造 `t_child_contract_times`
--

CREATE TABLE `t_child_contract_times` (
  `id` bigint UNSIGNED NOT NULL,
  `child_id` int NOT NULL COMMENT '児童ID',
  `day_category_id` tinyint NOT NULL COMMENT '曜日ID',
  `contract_flag` tinyint NOT NULL DEFAULT '0' COMMENT '保育契約フラグ 0:無効、1:有効',
  `contract_time_from` time DEFAULT NULL COMMENT '保育契約開始時間',
  `contract_time_to` time DEFAULT NULL COMMENT '保育契約終了時間',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- テーブルの構造 `t_child_extention_charges`
--

CREATE TABLE `t_child_extention_charges` (
  `manage_id` bigint UNSIGNED NOT NULL COMMENT '管理ID',
  `child_id` int NOT NULL COMMENT '児童ID',
  `nursery_id` int NOT NULL COMMENT 'nursery_id',
  `year` int NOT NULL COMMENT '年',
  `month` int NOT NULL COMMENT '月',
  `charge_id` int NOT NULL COMMENT '延長料金ID',
  `price` int NOT NULL COMMENT '金額',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- テーブルの構造 `t_child_extention_settings`
--

CREATE TABLE `t_child_extention_settings` (
  `manage_id` bigint UNSIGNED NOT NULL COMMENT '管理ID',
  `child_id` int NOT NULL COMMENT '児童ID',
  `nursery_id` int NOT NULL COMMENT '保育所ID',
  `year` int NOT NULL COMMENT '年',
  `month` int NOT NULL COMMENT '月',
  `nurture_amount` int NOT NULL COMMENT '保育必要量',
  `output` int NOT NULL COMMENT '出力選択',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- テーブルの構造 `t_child_goods`
--

CREATE TABLE `t_child_goods` (
  `manage_id` bigint UNSIGNED NOT NULL COMMENT '管理ID',
  `child_id` int NOT NULL COMMENT '児童ID',
  `year` int NOT NULL COMMENT '年',
  `month` int NOT NULL COMMENT '月',
  `day` int NOT NULL COMMENT '日',
  `goods_id` int NOT NULL COMMENT '物品ID',
  `amount` int DEFAULT NULL COMMENT '個数',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- テーブルの構造 `t_child_monthly_fees`
--

CREATE TABLE `t_child_monthly_fees` (
  `manage_id` bigint UNSIGNED NOT NULL COMMENT '管理ID',
  `child_id` int NOT NULL COMMENT '児童ID',
  `year` int NOT NULL COMMENT '年',
  `month` int NOT NULL COMMENT '月',
  `fee_id` int NOT NULL COMMENT '月極金額ID',
  `price` int DEFAULT NULL COMMENT '金額',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- テーブルの構造 `t_child_nurture_amounts`
--

CREATE TABLE `t_child_nurture_amounts` (
  `child_nurture_amount_id` int UNSIGNED NOT NULL COMMENT '児童毎保育量ID',
  `child_id` int NOT NULL COMMENT '児童ID',
  `target_year_month` date NOT NULL COMMENT '対象年月',
  `nurture_amount` tinyint NOT NULL DEFAULT '0' COMMENT '保育量種別 0：標準時間 1：短時間',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- テーブルの構造 `t_communication_board`
--

CREATE TABLE `t_communication_board` (
  `post_id` bigint UNSIGNED NOT NULL COMMENT '投稿ID',
  `nursery_id` int NOT NULL COMMENT '保育所ID',
  `employee_id` int NOT NULL COMMENT '投稿者ID(従業員ID)',
  `posting_date` date NOT NULL COMMENT '投稿日',
  `posting_time` time NOT NULL COMMENT '投稿時刻',
  `release_term` date DEFAULT NULL COMMENT '公開期限',
  `top_fixed` tinyint NOT NULL COMMENT '優先表示フラグ',
  `post_type` tinyint NOT NULL COMMENT '投稿種別',
  `text_body` varchar(500) COLLATE utf8mb4_general_ci NOT NULL COMMENT '本文',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- テーブルの構造 `t_confirmation_status`
--

CREATE TABLE `t_confirmation_status` (
  `id` bigint UNSIGNED NOT NULL COMMENT 'ID',
  `post_id` int NOT NULL COMMENT '投稿ID',
  `employee_id` int NOT NULL COMMENT '従業員ID',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- テーブルの構造 `t_dailywork_configs`
--

CREATE TABLE `t_dailywork_configs` (
  `id` int UNSIGNED NOT NULL COMMENT 'ID',
  `nursery_id` int UNSIGNED NOT NULL COMMENT '保育所ID',
  `display_order` int NOT NULL COMMENT '表示順',
  `display_id` int NOT NULL COMMENT 'フォームID',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- テーブルの構造 `t_daily_plans`
--

CREATE TABLE `t_daily_plans` (
  `plan_id` int UNSIGNED NOT NULL COMMENT '日案ID',
  `nursery_id` int NOT NULL COMMENT '保育所ID',
  `target_date` date NOT NULL COMMENT '対象日',
  `age` int DEFAULT NULL COMMENT '年齢',
  `class_id` int NOT NULL COMMENT 'クラスID',
  `child_count` int NOT NULL COMMENT '児童数',
  `teacher` int NOT NULL COMMENT '保育者',
  `daily_target` text COLLATE utf8mb4_general_ci COMMENT 'ねらい',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- テーブルの構造 `t_daily_plan_images`
--

CREATE TABLE `t_daily_plan_images` (
  `image_id` int UNSIGNED NOT NULL COMMENT '管理ID',
  `plan_id` int NOT NULL COMMENT '日案ID',
  `image_index` int NOT NULL COMMENT '画像インデックス(日案内での画像の順番)',
  `image_path` text COLLATE utf8mb4_general_ci NOT NULL COMMENT '画像パス',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- テーブルの構造 `t_daily_plan_manages`
--

CREATE TABLE `t_daily_plan_manages` (
  `manage_id` int UNSIGNED NOT NULL COMMENT '管理ID',
  `plan_id` int NOT NULL COMMENT '日案ID',
  `hour` int NOT NULL COMMENT '時間',
  `minute` int NOT NULL COMMENT '分',
  `item_id` int NOT NULL COMMENT '項目ID',
  `sort` tinyint DEFAULT NULL COMMENT '表示順',
  `value` text COLLATE utf8mb4_general_ci COMMENT '値',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- テーブルの構造 `t_developmental_records`
--

CREATE TABLE `t_developmental_records` (
  `record_id` bigint UNSIGNED NOT NULL COMMENT '発達記録ID',
  `nursery_id` int NOT NULL COMMENT '保育所ID',
  `child_id` int NOT NULL COMMENT '児童ID',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- テーブルの構造 `t_developmental_record_manages`
--

CREATE TABLE `t_developmental_record_manages` (
  `manage_id` bigint UNSIGNED NOT NULL COMMENT '管理ID',
  `record_id` int NOT NULL COMMENT '発達記録ID',
  `category_id` int NOT NULL COMMENT '領域ID',
  `item_id` int NOT NULL COMMENT '項目ID',
  `achieved_date` date DEFAULT NULL COMMENT '形成日付',
  `achieved_past` tinyint NOT NULL DEFAULT '0' COMMENT '入園前形成済 0:未形成 1:形成済',
  `remarks` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '備考',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- テーブルの構造 `t_extention_child_contract_times`
--

CREATE TABLE `t_extention_child_contract_times` (
  `id` bigint UNSIGNED NOT NULL COMMENT '管理ID',
  `year` int NOT NULL COMMENT '年',
  `month` int NOT NULL COMMENT '月',
  `child_id` int NOT NULL COMMENT '児童ID',
  `nursery_id` int NOT NULL COMMENT '保育所ID',
  `day_category_id` int NOT NULL COMMENT '曜日ID',
  `contract_flag` int NOT NULL COMMENT '保育契約フラグ 0:無効 1:有効',
  `contract_time_from` time DEFAULT NULL COMMENT '保育契約開始時間',
  `contract_time_to` time DEFAULT NULL COMMENT '保育契約終了時間',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- テーブルの構造 `t_healths`
--

CREATE TABLE `t_healths` (
  `health_id` int UNSIGNED NOT NULL COMMENT '健康チェックID',
  `nursery_id` int NOT NULL COMMENT '保育所ID',
  `date` date NOT NULL COMMENT '年月日',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- テーブルの構造 `t_health_defecation`
--

CREATE TABLE `t_health_defecation` (
  `manage_id` int UNSIGNED NOT NULL COMMENT '管理ID',
  `relation_id` int NOT NULL COMMENT '紐付ID',
  `time` time NOT NULL COMMENT '時刻',
  `category` int NOT NULL COMMENT '排便の方法',
  `status` int NOT NULL COMMENT '排便の種類',
  `employee_id` int NOT NULL COMMENT '記録者',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- テーブルの構造 `t_health_manages`
--

CREATE TABLE `t_health_manages` (
  `manage_id` int UNSIGNED NOT NULL COMMENT '管理ID',
  `relation_id` int UNSIGNED NOT NULL COMMENT '紐付ID',
  `item_id` int UNSIGNED NOT NULL COMMENT '項目ID',
  `status` int NOT NULL COMMENT '状態',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- テーブルの構造 `t_health_relations`
--

CREATE TABLE `t_health_relations` (
  `relation_id` int UNSIGNED NOT NULL COMMENT '紐付ID',
  `health_id` int NOT NULL COMMENT '健康チェックID',
  `child_id` int NOT NULL COMMENT '児童ID',
  `time` time DEFAULT NULL COMMENT '時刻',
  `remarks` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '備考',
  `employee_id` int DEFAULT NULL COMMENT '記録者',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- テーブルの構造 `t_health_thermometry`
--

CREATE TABLE `t_health_thermometry` (
  `manage_id` int UNSIGNED NOT NULL COMMENT '管理ID',
  `relation_id` int NOT NULL COMMENT '紐付ID',
  `time` time NOT NULL COMMENT '時刻',
  `thermometry` double NOT NULL COMMENT '体温',
  `employee_id` int NOT NULL COMMENT '記録者',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- テーブルの構造 `t_incident_reports`
--

CREATE TABLE `t_incident_reports` (
  `incident_id` bigint UNSIGNED NOT NULL COMMENT '報告書ID',
  `incident_type` tinyint NOT NULL COMMENT '報告書種別',
  `target_date` timestamp NOT NULL COMMENT '発生日時',
  `title` varchar(100) COLLATE utf8mb4_general_ci NOT NULL COMMENT 'タイトル',
  `nursery_id` int NOT NULL COMMENT '保育所ID',
  `record_date` date NOT NULL COMMENT '記録日',
  `recorder` int NOT NULL COMMENT '記録者',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- テーブルの構造 `t_incident_report_children`
--

CREATE TABLE `t_incident_report_children` (
  `manage_id` bigint UNSIGNED NOT NULL COMMENT '管理ID',
  `incident_id` int NOT NULL COMMENT '報告書ID',
  `child_id` int NOT NULL COMMENT '児童ID',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- テーブルの構造 `t_incident_report_images`
--

CREATE TABLE `t_incident_report_images` (
  `image_id` bigint UNSIGNED NOT NULL COMMENT '管理ID',
  `incident_id` int NOT NULL COMMENT '報告書ID',
  `image_index` int NOT NULL COMMENT '画像インデックス（ヒヤリハット・事故内での画像の順番）',
  `image_path` text COLLATE utf8mb4_general_ci NOT NULL COMMENT '画像パス',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- テーブルの構造 `t_incident_report_manages`
--

CREATE TABLE `t_incident_report_manages` (
  `manage_id` bigint UNSIGNED NOT NULL COMMENT '管理ID',
  `incident_id` int NOT NULL COMMENT '報告書ID',
  `item_id` int NOT NULL COMMENT '項目ID',
  `sort` int DEFAULT NULL COMMENT '表示順',
  `value` text COLLATE utf8mb4_general_ci COMMENT '値',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- テーブルの構造 `t_meal_inspection_records`
--

CREATE TABLE `t_meal_inspection_records` (
  `record_id` bigint UNSIGNED NOT NULL COMMENT '検食簿ID',
  `nursery_id` int NOT NULL COMMENT '保育所ID',
  `target_date` date NOT NULL COMMENT '対象日',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- テーブルの構造 `t_meal_inspection_record_images`
--

CREATE TABLE `t_meal_inspection_record_images` (
  `image_id` bigint UNSIGNED NOT NULL COMMENT '画像ID',
  `record_id` int NOT NULL COMMENT '検食簿ID',
  `meal_category_id` int NOT NULL COMMENT '食事種別ID',
  `image_path` varchar(255) COLLATE utf8mb4_general_ci NOT NULL COMMENT '画像パス',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- テーブルの構造 `t_meal_inspection_record_manages`
--

CREATE TABLE `t_meal_inspection_record_manages` (
  `manage_id` bigint UNSIGNED NOT NULL COMMENT '管理ID',
  `record_id` int NOT NULL COMMENT '検食簿ID',
  `meal_category_id` int NOT NULL COMMENT '食事種別ID',
  `menu_name` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '献立名',
  `teacher` int DEFAULT NULL COMMENT '検食者ID',
  `hour` int DEFAULT NULL COMMENT '時間',
  `minute` int DEFAULT NULL COMMENT '分',
  `temperature` double DEFAULT NULL COMMENT '温度',
  `humidity` double DEFAULT NULL COMMENT '湿度',
  `item_id` int NOT NULL COMMENT '入力項目ID',
  `value` text COLLATE utf8mb4_general_ci COMMENT '値',
  `sort_category` int DEFAULT NULL COMMENT '食事種別表示順',
  `sort_item` int DEFAULT NULL COMMENT '項目表示順',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- テーブルの構造 `t_messages`
--

CREATE TABLE `t_messages` (
  `message_id` int UNSIGNED NOT NULL COMMENT 'メッセージID',
  `sender` int DEFAULT NULL COMMENT '送信者(従業員ID)',
  `user_id` int NOT NULL COMMENT 'ユーザーID',
  `recipient_nurseries` text COLLATE utf8mb4_general_ci COMMENT '宛先保育所',
  `recipient_classes` text COLLATE utf8mb4_general_ci COMMENT '宛先クラス',
  `recipient_ids` text COLLATE utf8mb4_general_ci COMMENT '宛先(受信者IDをカンマで連結)',
  `bcc` text COLLATE utf8mb4_general_ci NOT NULL COMMENT 'メール連絡をコピー送付する宛先',
  `title` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '件名',
  `text_body` text COLLATE utf8mb4_general_ci COMMENT '本文',
  `data` text COLLATE utf8mb4_general_ci COMMENT '添付ファイル',
  `status` tinyint NOT NULL COMMENT 'ステータス１：下書き ２：予約 ３：送信済み ４：送信失敗 5：送信中',
  `reservation_date` timestamp NULL DEFAULT NULL COMMENT '予約日時',
  `sent_at` timestamp NULL DEFAULT NULL COMMENT '送信完了日時',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- テーブルの構造 `t_message_recipients`
--

CREATE TABLE `t_message_recipients` (
  `message_recipient_id` int UNSIGNED NOT NULL COMMENT '受信者ID',
  `child_id` int NOT NULL COMMENT '児童ID',
  `mail` varchar(255) COLLATE utf8mb4_general_ci NOT NULL COMMENT 'メールアドレス',
  `relationship` tinyint NOT NULL COMMENT '続柄',
  `recipient_token` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT 'メールアドレス登録用トークン　本登録後はNULL',
  `expiration_date` datetime DEFAULT NULL COMMENT 'メールアドレス登録の認証有効期限(24h)　本登録後はNULL',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- テーブルの構造 `t_monthly_plans`
--

CREATE TABLE `t_monthly_plans` (
  `plan_id` int UNSIGNED NOT NULL COMMENT '月案ID',
  `nursery_id` int NOT NULL COMMENT '保育所ID',
  `target_date` date NOT NULL COMMENT '対象日',
  `age` int DEFAULT NULL COMMENT '年齢',
  `class_id` int NOT NULL COMMENT 'クラスID',
  `teacher` int NOT NULL COMMENT '記録者',
  `monthly_target` text COLLATE utf8mb4_general_ci COMMENT '月のねらい',
  `lastmonth_status` text COLLATE utf8mb4_general_ci COMMENT '前月の子どもの姿',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- テーブルの構造 `t_monthly_plan_manages`
--

CREATE TABLE `t_monthly_plan_manages` (
  `manage_id` int UNSIGNED NOT NULL COMMENT '管理ID',
  `plan_id` int NOT NULL COMMENT '月案ID',
  `item_id` int NOT NULL COMMENT '項目ID',
  `sort` tinyint DEFAULT NULL COMMENT '表示順',
  `value` text COLLATE utf8mb4_general_ci COMMENT '値',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- テーブルの構造 `t_nursery_extention_charge_contract_price_settings`
--

CREATE TABLE `t_nursery_extention_charge_contract_price_settings` (
  `manage_id` bigint UNSIGNED NOT NULL COMMENT '管理ID',
  `nursery_id` int NOT NULL COMMENT '保育所ID',
  `year` int NOT NULL COMMENT '年',
  `month` int NOT NULL COMMENT '月',
  `category_id` int NOT NULL COMMENT 'カテゴリ',
  `time_unit` int NOT NULL COMMENT '単位（〇分毎）',
  `fraction` int NOT NULL COMMENT '端数（切上げ／切捨て）',
  `price_zero_year_old` int DEFAULT NULL COMMENT '値段（0歳児）',
  `price_one_year_old` int DEFAULT NULL COMMENT '値段（1歳児）',
  `price_two_years_old` int DEFAULT NULL COMMENT '値段（2歳児）',
  `price_three_years_old` int DEFAULT NULL COMMENT '値段（3歳児）',
  `price_four_years_old` int DEFAULT NULL COMMENT '値段（4歳児）',
  `price_five_years_old` int DEFAULT NULL COMMENT '値段（5歳児）',
  `border` int NOT NULL COMMENT '境界',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- テーブルの構造 `t_nursery_extention_charge_contract_time_settings`
--

CREATE TABLE `t_nursery_extention_charge_contract_time_settings` (
  `manage_id` bigint UNSIGNED NOT NULL COMMENT '管理ID',
  `nursery_id` int NOT NULL COMMENT '保育所ID',
  `year` int NOT NULL COMMENT '年',
  `month` int NOT NULL COMMENT '月',
  `category_id` int NOT NULL COMMENT 'カテゴリ',
  `start_time` time DEFAULT NULL COMMENT '開始時間',
  `end_time` time DEFAULT NULL COMMENT '終了時間',
  `nurture_amount` int NOT NULL COMMENT '保育必要量',
  `availability` int NOT NULL COMMENT '使用可否',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- テーブルの構造 `t_nursery_extention_charge_price_settings`
--

CREATE TABLE `t_nursery_extention_charge_price_settings` (
  `manage_id` bigint UNSIGNED NOT NULL COMMENT '管理ID',
  `nursery_id` int NOT NULL COMMENT '保育所ID',
  `year` int NOT NULL COMMENT '年',
  `month` int NOT NULL COMMENT '月',
  `category_id` int NOT NULL COMMENT 'カテゴリ',
  `time_unit` int NOT NULL COMMENT '単位（〇分毎）',
  `fraction` int NOT NULL COMMENT '端数（切上げ／切捨て）',
  `price_zero_year_old` int DEFAULT NULL COMMENT '値段（0歳児）',
  `price_one_year_old` int DEFAULT NULL COMMENT '値段（1歳児）',
  `price_two_years_old` int DEFAULT NULL COMMENT '値段（2歳児）',
  `price_three_years_old` int DEFAULT NULL COMMENT '値段（3歳児）',
  `price_four_years_old` int DEFAULT NULL COMMENT '値段（4歳児）',
  `price_five_years_old` int DEFAULT NULL COMMENT '値段（5歳児）',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- テーブルの構造 `t_nursery_extention_charge_time_settings`
--

CREATE TABLE `t_nursery_extention_charge_time_settings` (
  `manage_id` bigint UNSIGNED NOT NULL COMMENT '管理ID',
  `nursery_id` int NOT NULL COMMENT '保育所ID',
  `year` int NOT NULL COMMENT '年',
  `month` int NOT NULL COMMENT '月',
  `category_id` int NOT NULL COMMENT 'カテゴリ',
  `start_time` time DEFAULT NULL COMMENT '開始時間',
  `end_time` time DEFAULT NULL COMMENT '終了時間',
  `nurture_amount` int NOT NULL COMMENT '保育必要量',
  `availability` int NOT NULL COMMENT '使用可否',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- テーブルの構造 `t_nursery_goods`
--

CREATE TABLE `t_nursery_goods` (
  `manage_id` bigint UNSIGNED NOT NULL COMMENT '管理ID',
  `nursery_id` int NOT NULL COMMENT '保育所ID',
  `year` int NOT NULL COMMENT '年',
  `month` int NOT NULL COMMENT '月',
  `goods_id` int NOT NULL COMMENT '物品ID',
  `goods_name` varchar(255) COLLATE utf8mb4_general_ci NOT NULL COMMENT '物品名',
  `price` int NOT NULL COMMENT '単価',
  `tax_type` int NOT NULL COMMENT '税種別',
  `sort` int NOT NULL COMMENT 'ソート順',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- テーブルの構造 `t_nursery_invoice_settings`
--

CREATE TABLE `t_nursery_invoice_settings` (
  `manage_id` bigint UNSIGNED NOT NULL COMMENT '管理ID',
  `nursery_id` int NOT NULL COMMENT '保育所ID',
  `year` int NOT NULL COMMENT '年',
  `month` int NOT NULL COMMENT '月',
  `invoice_info` int NOT NULL COMMENT '請求先指定',
  `bank_name` varchar(255) COLLATE utf8mb4_general_ci NOT NULL COMMENT '銀行名',
  `branch_name` varchar(255) COLLATE utf8mb4_general_ci NOT NULL COMMENT '支店名',
  `account_type` int NOT NULL COMMENT '預金種目',
  `account_number` varchar(7) COLLATE utf8mb4_general_ci NOT NULL COMMENT '口座番号',
  `account_name` varchar(255) COLLATE utf8mb4_general_ci NOT NULL COMMENT '口座名義',
  `tax_type` int NOT NULL COMMENT '延長保育料の税種別',
  `tax_rate` int NOT NULL COMMENT '税率',
  `calculation_method` tinyint NOT NULL DEFAULT '0' COMMENT '延長料金計算方式',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- テーブルの構造 `t_nursery_monthly_fees`
--

CREATE TABLE `t_nursery_monthly_fees` (
  `manage_id` bigint UNSIGNED NOT NULL COMMENT '管理ID',
  `nursery_id` int NOT NULL COMMENT '保育所ID',
  `year` int NOT NULL COMMENT '年',
  `month` int NOT NULL COMMENT '月',
  `fee_id` int NOT NULL COMMENT '月極金額ID',
  `fee_name` varchar(255) COLLATE utf8mb4_general_ci NOT NULL COMMENT '月極金額名',
  `tax_type` int NOT NULL COMMENT '税種別',
  `sort` int NOT NULL COMMENT 'ソート順',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- テーブルの構造 `t_nurture_diaries`
--

CREATE TABLE `t_nurture_diaries` (
  `diary_id` int UNSIGNED NOT NULL COMMENT '保育日誌ID',
  `nursery_id` int NOT NULL COMMENT '保育所ID',
  `target_date` date NOT NULL COMMENT '対象日',
  `temperature` decimal(4,1) DEFAULT NULL COMMENT '温度',
  `humidity` decimal(4,1) DEFAULT NULL COMMENT '湿度',
  `class_id` int NOT NULL COMMENT 'クラスID',
  `teacher` int NOT NULL COMMENT '記録者',
  `attendance_remarks` text COLLATE utf8mb4_general_ci COMMENT '出欠の特記事項',
  `absence_reason1` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '欠席理由1',
  `absence_reason2` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '欠席理由2',
  `absence_reason3` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '欠席理由3',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- テーブルの構造 `t_nurture_diary_images`
--

CREATE TABLE `t_nurture_diary_images` (
  `id` int UNSIGNED NOT NULL,
  `image_id` int UNSIGNED NOT NULL COMMENT '画像ID',
  `t_nurture_diary_id` int UNSIGNED NOT NULL COMMENT '保育日誌ID',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- テーブルの構造 `t_nurture_diary_manages`
--

CREATE TABLE `t_nurture_diary_manages` (
  `manage_id` int UNSIGNED NOT NULL COMMENT '管理ID',
  `diary_id` int NOT NULL COMMENT '保育日誌ID',
  `item_id` int NOT NULL COMMENT '項目ID',
  `sort` tinyint DEFAULT NULL COMMENT '表示順',
  `value` text COLLATE utf8mb4_general_ci COMMENT '値',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- テーブルの構造 `t_nurture_schedules`
--

CREATE TABLE `t_nurture_schedules` (
  `nurture_schedule_id` bigint UNSIGNED NOT NULL COMMENT 'スケジュールID',
  `child_id` int NOT NULL COMMENT '児童ID',
  `school_day` date NOT NULL COMMENT '年月日',
  `attendance_time` time DEFAULT NULL COMMENT '登園時間',
  `leaving_time` time DEFAULT NULL COMMENT '降園時間',
  `remarks` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '備考',
  `cooperate_attendance_time` time DEFAULT NULL COMMENT '連携システム登園時間',
  `cooperate_leaving_time` time DEFAULT NULL COMMENT '連携システム降園時間',
  `cooperate_remarks` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '連携システム備考',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- テーブルの構造 `t_optional_items`
--

CREATE TABLE `t_optional_items` (
  `optional_id` bigint UNSIGNED NOT NULL COMMENT '管理ID',
  `attendance_id` int NOT NULL COMMENT '勤怠管理ID',
  `item_id` int NOT NULL COMMENT '項目ID',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- テーブルの構造 `t_optional_item_patterns`
--

CREATE TABLE `t_optional_item_patterns` (
  `manage_id` bigint UNSIGNED NOT NULL COMMENT '管理ID',
  `pattern_id` int NOT NULL COMMENT '任意項目設定ID',
  `item_id` bigint NOT NULL COMMENT '項目ID',
  `timing` tinyint NOT NULL COMMENT '表示タイミング 0：両方 1：出勤時 2：退勤時',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- テーブルの構造 `t_optional_patterns`
--

CREATE TABLE `t_optional_patterns` (
  `pattern_id` bigint UNSIGNED NOT NULL COMMENT '任意項目設定ID',
  `nursery_id` int NOT NULL COMMENT '保育所ID',
  `start_date` date NOT NULL COMMENT '適用開始日',
  `end_date` date DEFAULT NULL COMMENT '適用終了日',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- テーブルの構造 `t_personal_manages`
--

CREATE TABLE `t_personal_manages` (
  `manage_id` int UNSIGNED NOT NULL COMMENT '管理ID',
  `personal_record_id` int NOT NULL COMMENT '個人記録ID',
  `item_id` int NOT NULL COMMENT '項目名',
  `sort` tinyint DEFAULT NULL COMMENT '表示順',
  `value` text COLLATE utf8mb4_general_ci COMMENT '値',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- テーブルの構造 `t_personal_records`
--

CREATE TABLE `t_personal_records` (
  `personal_record_id` int UNSIGNED NOT NULL COMMENT '個人記録ID',
  `child_id` int NOT NULL COMMENT '児童ID',
  `target_date` date NOT NULL COMMENT '対象日',
  `teacher` int NOT NULL COMMENT '記録者',
  `next_month_target` text COLLATE utf8mb4_general_ci COMMENT '来月の課題',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- テーブルの構造 `t_shift_schedules`
--

CREATE TABLE `t_shift_schedules` (
  `shift_schedule_id` int UNSIGNED NOT NULL COMMENT 'シフトスケジュールID',
  `employees_id` int NOT NULL COMMENT '社員ID',
  `date` date NOT NULL COMMENT '日付',
  `week_day` tinyint NOT NULL COMMENT '曜日',
  `work_location_id` int DEFAULT NULL COMMENT '勤務園ID',
  `shift_id` int DEFAULT NULL COMMENT 'シフト管理ID',
  `vacation` int DEFAULT NULL COMMENT '休暇区分',
  `attendance_time` time DEFAULT NULL COMMENT '登園時間',
  `leaving_time` time DEFAULT NULL COMMENT '降園時間',
  `break_time` time DEFAULT NULL COMMENT '休憩時間',
  `remarks` text COLLATE utf8mb4_general_ci COMMENT '備考',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- テーブルの構造 `t_shift_schedule_details`
--

CREATE TABLE `t_shift_schedule_details` (
  `detail_id` bigint UNSIGNED NOT NULL COMMENT '履歴ID',
  `t_shift_schedule_id` int NOT NULL COMMENT 'シフトスケジュールID',
  `engagement_category` tinyint NOT NULL COMMENT '従事区分:1:保育従事 2:その他',
  `start_time` time NOT NULL COMMENT '開始時間',
  `end_time` time DEFAULT NULL COMMENT '終了時間',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- テーブルの構造 `t_sleeps`
--

CREATE TABLE `t_sleeps` (
  `sleep_id` int UNSIGNED NOT NULL COMMENT '睡眠チェックID',
  `nursery_id` int NOT NULL COMMENT '保育所ID',
  `date` date NOT NULL COMMENT '年月日',
  `temperature` decimal(4,1) DEFAULT NULL COMMENT '気温',
  `humidity` decimal(4,1) DEFAULT NULL COMMENT '湿度',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- テーブルの構造 `t_sleep_class_climate_logs`
--

CREATE TABLE `t_sleep_class_climate_logs` (
  `id` int UNSIGNED NOT NULL,
  `sleep_id` int NOT NULL COMMENT '睡眠チェックID',
  `class_id` int NOT NULL COMMENT 'クラスID',
  `temperature` decimal(4,1) DEFAULT NULL COMMENT '温度',
  `humidity` decimal(4,1) DEFAULT NULL COMMENT '湿度',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- テーブルの構造 `t_sleep_class_remarks`
--

CREATE TABLE `t_sleep_class_remarks` (
  `sleep_class_remark_id` int UNSIGNED NOT NULL COMMENT '睡眠チェッククラス備考ID',
  `sleep_id` int NOT NULL COMMENT '睡眠チェックID',
  `class_id` int NOT NULL COMMENT 'クラスID',
  `body` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '備考',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- テーブルの構造 `t_sleep_manages`
--

CREATE TABLE `t_sleep_manages` (
  `manage_id` int UNSIGNED NOT NULL COMMENT '管理ID',
  `sleep_id` int NOT NULL COMMENT '睡眠チェックID',
  `child_id` int NOT NULL COMMENT '児童ID',
  `time` time NOT NULL COMMENT '時刻',
  `status` int NOT NULL COMMENT '睡眠状態',
  `lying_posture` int DEFAULT NULL COMMENT '寝姿勢',
  `remarks` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '備考',
  `employee_id` int NOT NULL COMMENT '記録者',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- テーブルの構造 `t_staffing_configs`
--

CREATE TABLE `t_staffing_configs` (
  `id` int UNSIGNED NOT NULL,
  `nursery_id` int NOT NULL COMMENT '保育所ID',
  `sum_one_and_two_flg` tinyint NOT NULL DEFAULT '0' COMMENT '1 歳児、2 歳児の人材配置をまとめて行う 0: false, 1: true',
  `sum_four_and_five_flg` tinyint NOT NULL DEFAULT '0' COMMENT '4 歳児、5 歳児の人材配置をまとめて行う 0: false, 1: true',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- テーブルの構造 `t_weathers`
--

CREATE TABLE `t_weathers` (
  `weather_id` int UNSIGNED NOT NULL COMMENT '天気ID',
  `nursery_id` int NOT NULL COMMENT '保育所ID',
  `weather_item_id` int NOT NULL COMMENT '項目ID',
  `date` date NOT NULL COMMENT '日付',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- テーブルの構造 `t_weekly_plans`
--

CREATE TABLE `t_weekly_plans` (
  `plan_id` int UNSIGNED NOT NULL COMMENT '週案ID',
  `nursery_id` int NOT NULL COMMENT '保育所ID',
  `target_date` date NOT NULL COMMENT '対象日',
  `age` int DEFAULT NULL COMMENT '年齢',
  `class_id` int NOT NULL COMMENT 'クラスID',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- テーブルの構造 `t_weekly_plan_headers`
--

CREATE TABLE `t_weekly_plan_headers` (
  `header_id` int UNSIGNED NOT NULL COMMENT '通し番号',
  `plan_id` int NOT NULL COMMENT 'プランID',
  `week` tinyint NOT NULL COMMENT '週数',
  `teacher` int DEFAULT NULL COMMENT '記録者',
  `weekly_target` text COLLATE utf8mb4_general_ci COMMENT '週の目標',
  `review` text COLLATE utf8mb4_general_ci COMMENT '評価・反省',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- テーブルの構造 `t_weekly_plan_manages`
--

CREATE TABLE `t_weekly_plan_manages` (
  `manage_id` int UNSIGNED NOT NULL COMMENT '管理ID',
  `plan_id` int NOT NULL COMMENT '週案ID',
  `date` int NOT NULL COMMENT '日',
  `item_id` int NOT NULL COMMENT '項目ID',
  `sort` tinyint DEFAULT NULL COMMENT '表示順',
  `value` text COLLATE utf8mb4_general_ci COMMENT '値',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- テーブルの構造 `t_yearly_plans`
--

CREATE TABLE `t_yearly_plans` (
  `plan_id` int UNSIGNED NOT NULL COMMENT '年間指導計画ID',
  `nursery_id` int NOT NULL COMMENT '保育所ID',
  `target_date` date NOT NULL COMMENT '対象日',
  `age` int DEFAULT NULL COMMENT '年齢',
  `class_id` int NOT NULL COMMENT 'クラスID',
  `teacher` int NOT NULL COMMENT '記録者',
  `yearly_target` text COLLATE utf8mb4_general_ci COMMENT '年間目標',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- テーブルの構造 `t_yearly_plan_manages`
--

CREATE TABLE `t_yearly_plan_manages` (
  `manage_id` int UNSIGNED NOT NULL COMMENT '管理ID',
  `plan_id` int NOT NULL COMMENT '年間指導計画ID',
  `term` int NOT NULL COMMENT '四半期',
  `item_id` int NOT NULL COMMENT '項目ID',
  `b_item_id` bigint NOT NULL COMMENT '年間指導計画期間マスタアイテムID',
  `sort` tinyint DEFAULT NULL COMMENT '表示順',
  `value` text COLLATE utf8mb4_general_ci COMMENT '値',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- ダンプしたテーブルのインデックス
--

--
-- テーブルのインデックス `attendance_changeable_times`
--
ALTER TABLE `attendance_changeable_times`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `attendance_changeable_times_nursery_id_unique` (`nursery_id`);

--
-- テーブルのインデックス `b_accident_items`
--
ALTER TABLE `b_accident_items`
  ADD PRIMARY KEY (`item_id`);

--
-- テーブルのインデックス `b_accident_regist_categories`
--
ALTER TABLE `b_accident_regist_categories`
  ADD PRIMARY KEY (`classify_id`);

--
-- テーブルのインデックス `b_attendance_configs`
--
ALTER TABLE `b_attendance_configs`
  ADD PRIMARY KEY (`config_id`);

--
-- テーブルのインデックス `b_business_log_items`
--
ALTER TABLE `b_business_log_items`
  ADD PRIMARY KEY (`item_id`);

--
-- テーブルのインデックス `b_business_log_regist_categories`
--
ALTER TABLE `b_business_log_regist_categories`
  ADD PRIMARY KEY (`classify_id`);

--
-- テーブルのインデックス `b_certified_personal_shift_templates`
--
ALTER TABLE `b_certified_personal_shift_templates`
  ADD PRIMARY KEY (`personal_shift_id`);

--
-- テーブルのインデックス `b_certified_personal_shift_template_details`
--
ALTER TABLE `b_certified_personal_shift_template_details`
  ADD PRIMARY KEY (`personal_shift_detail_id`);

--
-- テーブルのインデックス `b_certified_shift_templates`
--
ALTER TABLE `b_certified_shift_templates`
  ADD PRIMARY KEY (`shift_id`);

--
-- テーブルのインデックス `b_certified_shift_template_details`
--
ALTER TABLE `b_certified_shift_template_details`
  ADD PRIMARY KEY (`shift_detail_id`);

--
-- テーブルのインデックス `b_children`
--
ALTER TABLE `b_children`
  ADD PRIMARY KEY (`child_id`),
  ADD UNIQUE KEY `b_children_token_unique` (`token`);

--
-- テーブルのインデックス `b_child_attendance_configs`
--
ALTER TABLE `b_child_attendance_configs`
  ADD PRIMARY KEY (`config_id`);

--
-- テーブルのインデックス `b_child_classes`
--
ALTER TABLE `b_child_classes`
  ADD PRIMARY KEY (`class_manage_id`),
  ADD KEY `b_child_classes_child_id_index` (`child_id`),
  ADD KEY `b_child_classes_nursery_history_id_index` (`nursery_history_id`),
  ADD KEY `b_child_classes_class_id_index` (`class_id`);

--
-- テーブルのインデックス `b_child_department_histories`
--
ALTER TABLE `b_child_department_histories`
  ADD PRIMARY KEY (`history_id`),
  ADD KEY `b_child_department_histories_nursery_id_index` (`nursery_id`),
  ADD KEY `b_child_department_histories_child_id_index` (`child_id`);

--
-- テーブルのインデックス `b_child_monthly_fees`
--
ALTER TABLE `b_child_monthly_fees`
  ADD PRIMARY KEY (`manage_id`);

--
-- テーブルのインデックス `b_child_support_terms`
--
ALTER TABLE `b_child_support_terms`
  ADD PRIMARY KEY (`id`);

--
-- テーブルのインデックス `b_classes`
--
ALTER TABLE `b_classes`
  ADD PRIMARY KEY (`class_id`),
  ADD KEY `b_classes_nursery_id_index` (`nursery_id`);

--
-- テーブルのインデックス `b_companies`
--
ALTER TABLE `b_companies`
  ADD PRIMARY KEY (`company_id`);

--
-- テーブルのインデックス `b_configs`
--
ALTER TABLE `b_configs`
  ADD PRIMARY KEY (`config_id`);

--
-- テーブルのインデックス `b_daily_plan_items`
--
ALTER TABLE `b_daily_plan_items`
  ADD PRIMARY KEY (`item_id`);

--
-- テーブルのインデックス `b_daily_plan_regist_categories`
--
ALTER TABLE `b_daily_plan_regist_categories`
  ADD PRIMARY KEY (`classify_id`);

--
-- テーブルのインデックス `b_developmental_record_categories`
--
ALTER TABLE `b_developmental_record_categories`
  ADD PRIMARY KEY (`item_id`);

--
-- テーブルのインデックス `b_developmental_record_cate_regist_categories`
--
ALTER TABLE `b_developmental_record_cate_regist_categories`
  ADD PRIMARY KEY (`classify_id`);

--
-- テーブルのインデックス `b_developmental_record_items`
--
ALTER TABLE `b_developmental_record_items`
  ADD PRIMARY KEY (`item_id`);

--
-- テーブルのインデックス `b_developmental_record_item_regist_categories`
--
ALTER TABLE `b_developmental_record_item_regist_categories`
  ADD PRIMARY KEY (`classify_id`),
  ADD KEY `b_developmental_record_item_regist_categories_category_id_index` (`category_id`);

--
-- テーブルのインデックス `b_employees`
--
ALTER TABLE `b_employees`
  ADD PRIMARY KEY (`employee_id`);

--
-- テーブルのインデックス `b_employee_department_histories`
--
ALTER TABLE `b_employee_department_histories`
  ADD PRIMARY KEY (`history_id`),
  ADD KEY `b_employee_department_histories_employee_id_index` (`employee_id`);

--
-- テーブルのインデックス `b_employee_qualifications`
--
ALTER TABLE `b_employee_qualifications`
  ADD PRIMARY KEY (`employee_qualification_id`);

--
-- テーブルのインデックス `b_employee_working_form_histories`
--
ALTER TABLE `b_employee_working_form_histories`
  ADD PRIMARY KEY (`history_id`);

--
-- テーブルのインデックス `b_events`
--
ALTER TABLE `b_events`
  ADD PRIMARY KEY (`event_id`);

--
-- テーブルのインデックス `b_extention_charge_invoice_settings`
--
ALTER TABLE `b_extention_charge_invoice_settings`
  ADD PRIMARY KEY (`nursery_id`);

--
-- テーブルのインデックス `b_extention_charge_price_contract_settings`
--
ALTER TABLE `b_extention_charge_price_contract_settings`
  ADD PRIMARY KEY (`price_id`);

--
-- テーブルのインデックス `b_extention_charge_price_settings`
--
ALTER TABLE `b_extention_charge_price_settings`
  ADD PRIMARY KEY (`price_id`);

--
-- テーブルのインデックス `b_extention_charge_time_contract_settings`
--
ALTER TABLE `b_extention_charge_time_contract_settings`
  ADD PRIMARY KEY (`charge_id`);

--
-- テーブルのインデックス `b_extention_charge_time_settings`
--
ALTER TABLE `b_extention_charge_time_settings`
  ADD PRIMARY KEY (`charge_id`);

--
-- テーブルのインデックス `b_families`
--
ALTER TABLE `b_families`
  ADD PRIMARY KEY (`family_id`),
  ADD UNIQUE KEY `b_families_token_unique` (`token`);

--
-- テーブルのインデックス `b_fixed_phrases`
--
ALTER TABLE `b_fixed_phrases`
  ADD PRIMARY KEY (`phrase_id`);

--
-- テーブルのインデックス `b_hourly_aggregation_configs`
--
ALTER TABLE `b_hourly_aggregation_configs`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `b_hourly_aggregation_configs_nursery_id_aggregation_time_unique` (`nursery_id`,`aggregation_time`);

--
-- テーブルのインデックス `b_ip_address_permissions`
--
ALTER TABLE `b_ip_address_permissions`
  ADD PRIMARY KEY (`id`);

--
-- テーブルのインデックス `b_item_configs`
--
ALTER TABLE `b_item_configs`
  ADD PRIMARY KEY (`config_id`);

--
-- テーブルのインデックス `b_meal_inspection_record_items`
--
ALTER TABLE `b_meal_inspection_record_items`
  ADD PRIMARY KEY (`item_id`);

--
-- テーブルのインデックス `b_meal_inspection_record_item_regist_categories`
--
ALTER TABLE `b_meal_inspection_record_item_regist_categories`
  ADD PRIMARY KEY (`classify_id`);

--
-- テーブルのインデックス `b_meal_inspection_record_meal_categories`
--
ALTER TABLE `b_meal_inspection_record_meal_categories`
  ADD PRIMARY KEY (`item_id`);

--
-- テーブルのインデックス `b_meal_inspection_record_meal_category_regist_categories`
--
ALTER TABLE `b_meal_inspection_record_meal_category_regist_categories`
  ADD PRIMARY KEY (`classify_id`);

--
-- テーブルのインデックス `b_monthly_plan_items`
--
ALTER TABLE `b_monthly_plan_items`
  ADD PRIMARY KEY (`item_id`);

--
-- テーブルのインデックス `b_monthly_plan_regist_categories`
--
ALTER TABLE `b_monthly_plan_regist_categories`
  ADD PRIMARY KEY (`classify_id`);

--
-- テーブルのインデックス `b_near_hit_items`
--
ALTER TABLE `b_near_hit_items`
  ADD PRIMARY KEY (`item_id`);

--
-- テーブルのインデックス `b_near_hit_regist_categories`
--
ALTER TABLE `b_near_hit_regist_categories`
  ADD PRIMARY KEY (`classify_id`);

--
-- テーブルのインデックス `b_nurseries`
--
ALTER TABLE `b_nurseries`
  ADD PRIMARY KEY (`nursery_id`);

--
-- テーブルのインデックス `b_nursery_bank_accounts`
--
ALTER TABLE `b_nursery_bank_accounts`
  ADD PRIMARY KEY (`account_id`);

--
-- テーブルのインデックス `b_nursery_goods`
--
ALTER TABLE `b_nursery_goods`
  ADD PRIMARY KEY (`goods_id`);

--
-- テーブルのインデックス `b_nursery_histories`
--
ALTER TABLE `b_nursery_histories`
  ADD PRIMARY KEY (`history_id`);

--
-- テーブルのインデックス `b_nursery_monthly_fees`
--
ALTER TABLE `b_nursery_monthly_fees`
  ADD PRIMARY KEY (`fee_id`);

--
-- テーブルのインデックス `b_nurture_diary_items`
--
ALTER TABLE `b_nurture_diary_items`
  ADD PRIMARY KEY (`item_id`);

--
-- テーブルのインデックス `b_nurture_diary_regist_categories`
--
ALTER TABLE `b_nurture_diary_regist_categories`
  ADD PRIMARY KEY (`classify_id`);

--
-- テーブルのインデックス `b_optional_item_items`
--
ALTER TABLE `b_optional_item_items`
  ADD PRIMARY KEY (`item_id`);

--
-- テーブルのインデックス `b_optional_item_regist_categories`
--
ALTER TABLE `b_optional_item_regist_categories`
  ADD PRIMARY KEY (`manage_id`);

--
-- テーブルのインデックス `b_personal_items`
--
ALTER TABLE `b_personal_items`
  ADD PRIMARY KEY (`item_id`);

--
-- テーブルのインデックス `b_personal_regist_categories`
--
ALTER TABLE `b_personal_regist_categories`
  ADD PRIMARY KEY (`classify_id`);

--
-- テーブルのインデックス `b_personal_shift_templates`
--
ALTER TABLE `b_personal_shift_templates`
  ADD PRIMARY KEY (`personal_shift_id`);

--
-- テーブルのインデックス `b_shift_templates`
--
ALTER TABLE `b_shift_templates`
  ADD PRIMARY KEY (`shift_id`);

--
-- テーブルのインデックス `b_staffings`
--
ALTER TABLE `b_staffings`
  ADD PRIMARY KEY (`staffing_id`);

--
-- テーブルのインデックス `b_term_items`
--
ALTER TABLE `b_term_items`
  ADD PRIMARY KEY (`item_id`);

--
-- テーブルのインデックス `b_term_regist_categories`
--
ALTER TABLE `b_term_regist_categories`
  ADD PRIMARY KEY (`classify_id`);

--
-- テーブルのインデックス `b_tokens`
--
ALTER TABLE `b_tokens`
  ADD PRIMARY KEY (`uniq_id`),
  ADD UNIQUE KEY `b_tokens_access_token_unique` (`access_token`);

--
-- テーブルのインデックス `b_users`
--
ALTER TABLE `b_users`
  ADD PRIMARY KEY (`user_id`);

--
-- テーブルのインデックス `b_user_auths`
--
ALTER TABLE `b_user_auths`
  ADD PRIMARY KEY (`user_auth_id`);

--
-- テーブルのインデックス `b_weather_items`
--
ALTER TABLE `b_weather_items`
  ADD PRIMARY KEY (`weather_item_id`);

--
-- テーブルのインデックス `b_weekly_plan_items`
--
ALTER TABLE `b_weekly_plan_items`
  ADD PRIMARY KEY (`item_id`);

--
-- テーブルのインデックス `b_weekly_plan_regist_categories`
--
ALTER TABLE `b_weekly_plan_regist_categories`
  ADD PRIMARY KEY (`classify_id`);

--
-- テーブルのインデックス `b_yearly_plan_items`
--
ALTER TABLE `b_yearly_plan_items`
  ADD PRIMARY KEY (`item_id`);

--
-- テーブルのインデックス `b_yearly_plan_regist_categories`
--
ALTER TABLE `b_yearly_plan_regist_categories`
  ADD PRIMARY KEY (`classify_id`);

--
-- テーブルのインデックス `child_attendances`
--
ALTER TABLE `child_attendances`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `child_attendances_unique` (`school_day`,`child_id`,`attendance_status_id`),
  ADD KEY `child_attendances_child_id_foreign` (`child_id`),
  ADD KEY `child_attendances_attendance_status_id_foreign` (`attendance_status_id`);

--
-- テーブルのインデックス `child_attendance_requests`
--
ALTER TABLE `child_attendance_requests`
  ADD PRIMARY KEY (`id`),
  ADD KEY `child_attendance_requests_child_id_foreign` (`child_id`),
  ADD KEY `child_attendance_requests_attendance_status_id_foreign` (`attendance_status_id`),
  ADD KEY `child_attendance_requests_read_employee_id_foreign` (`read_employee_id`);

--
-- テーブルのインデックス `child_attendance_statuses`
--
ALTER TABLE `child_attendance_statuses`
  ADD PRIMARY KEY (`id`);

--
-- テーブルのインデックス `child_notice`
--
ALTER TABLE `child_notice`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `child_notice_notice_id_child_id_unique` (`notice_id`,`child_id`),
  ADD KEY `child_notice_child_id_foreign` (`child_id`);

--
-- テーブルのインデックス `class_notice`
--
ALTER TABLE `class_notice`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `class_notice_notice_id_class_id_unique` (`notice_id`,`class_id`),
  ADD KEY `class_notice_class_id_foreign` (`class_id`);

--
-- テーブルのインデックス `communication_board_attached_files`
--
ALTER TABLE `communication_board_attached_files`
  ADD PRIMARY KEY (`id`),
  ADD KEY `attached_files_t_communication_board_id_foreign` (`t_communication_board_id`);

--
-- テーブルのインデックス `defecation_categories`
--
ALTER TABLE `defecation_categories`
  ADD PRIMARY KEY (`id`);

--
-- テーブルのインデックス `defecation_statuses`
--
ALTER TABLE `defecation_statuses`
  ADD PRIMARY KEY (`id`);

--
-- テーブルのインデックス `diseases`
--
ALTER TABLE `diseases`
  ADD PRIMARY KEY (`id`);

--
-- テーブルのインデックス `employee_broadcast_messages`
--
ALTER TABLE `employee_broadcast_messages`
  ADD PRIMARY KEY (`id`),
  ADD KEY `employee_broadcast_messages_nurture_diary_id_foreign` (`nurture_diary_id`);

--
-- テーブルのインデックス `employee_messages`
--
ALTER TABLE `employee_messages`
  ADD PRIMARY KEY (`id`),
  ADD KEY `employee_messages_message_status_id_foreign` (`message_status_id`),
  ADD KEY `employee_messages_employee_id_foreign` (`employee_id`),
  ADD KEY `employee_messages_note_contact_id_foreign` (`note_contact_id`);

--
-- テーブルのインデックス `employee_message_images`
--
ALTER TABLE `employee_message_images`
  ADD PRIMARY KEY (`id`),
  ADD KEY `employee_message_images_image_id_foreign` (`image_id`),
  ADD KEY `employee_message_images_employee_message_id_foreign` (`employee_message_id`);

--
-- テーブルのインデックス `employee_message_statuses`
--
ALTER TABLE `employee_message_statuses`
  ADD PRIMARY KEY (`id`);

--
-- テーブルのインデックス `employee_orders`
--
ALTER TABLE `employee_orders`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `employee_orders_employee_id_unique` (`employee_id`);

--
-- テーブルのインデックス `failed_jobs`
--
ALTER TABLE `failed_jobs`
  ADD PRIMARY KEY (`id`);

--
-- テーブルのインデックス `family_contacts`
--
ALTER TABLE `family_contacts`
  ADD PRIMARY KEY (`id`),
  ADD KEY `family_contacts_note_contact_id_foreign` (`note_contact_id`);

--
-- テーブルのインデックス `family_defecations`
--
ALTER TABLE `family_defecations`
  ADD PRIMARY KEY (`id`),
  ADD KEY `family_defecations_category_id_foreign` (`category_id`),
  ADD KEY `family_defecations_status_id_foreign` (`status_id`),
  ADD KEY `family_defecations_family_contact_id_foreign` (`family_contact_id`);

--
-- テーブルのインデックス `family_meals`
--
ALTER TABLE `family_meals`
  ADD PRIMARY KEY (`id`),
  ADD KEY `family_meals_category_id_foreign` (`category_id`),
  ADD KEY `family_meals_family_contact_id_foreign` (`family_contact_id`);

--
-- テーブルのインデックス `family_messages`
--
ALTER TABLE `family_messages`
  ADD PRIMARY KEY (`id`),
  ADD KEY `family_messages_family_contact_id_foreign` (`family_contact_id`);

--
-- テーブルのインデックス `family_sleeps`
--
ALTER TABLE `family_sleeps`
  ADD PRIMARY KEY (`id`),
  ADD KEY `family_sleeps_family_contact_id_foreign` (`family_contact_id`);

--
-- テーブルのインデックス `family_thermometries`
--
ALTER TABLE `family_thermometries`
  ADD PRIMARY KEY (`id`),
  ADD KEY `family_thermometries_family_contact_id_foreign` (`family_contact_id`);

--
-- テーブルのインデックス `images`
--
ALTER TABLE `images`
  ADD PRIMARY KEY (`id`);

--
-- テーブルのインデックス `meal_categories`
--
ALTER TABLE `meal_categories`
  ADD PRIMARY KEY (`id`);

--
-- テーブルのインデックス `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- テーブルのインデックス `m_allergy_categories`
--
ALTER TABLE `m_allergy_categories`
  ADD PRIMARY KEY (`category_id`);

--
-- テーブルのインデックス `m_allergy_items`
--
ALTER TABLE `m_allergy_items`
  ADD PRIMARY KEY (`item_id`);

--
-- テーブルのインデックス `m_auths`
--
ALTER TABLE `m_auths`
  ADD PRIMARY KEY (`auth_id`);

--
-- テーブルのインデックス `m_employment_patterns`
--
ALTER TABLE `m_employment_patterns`
  ADD PRIMARY KEY (`employment_pattern_id`);

--
-- テーブルのインデックス `m_functions`
--
ALTER TABLE `m_functions`
  ADD PRIMARY KEY (`function_id`);

--
-- テーブルのインデックス `m_function_auths`
--
ALTER TABLE `m_function_auths`
  ADD PRIMARY KEY (`function_auth_id`);

--
-- テーブルのインデックス `m_health_items`
--
ALTER TABLE `m_health_items`
  ADD PRIMARY KEY (`item_id`);

--
-- テーブルのインデックス `m_positions`
--
ALTER TABLE `m_positions`
  ADD PRIMARY KEY (`position_id`);

--
-- テーブルのインデックス `m_prefectures`
--
ALTER TABLE `m_prefectures`
  ADD PRIMARY KEY (`prefecture_id`);

--
-- テーブルのインデックス `m_qualifications`
--
ALTER TABLE `m_qualifications`
  ADD PRIMARY KEY (`qualification_id`);

--
-- テーブルのインデックス `note_contacts`
--
ALTER TABLE `note_contacts`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `note_contacts_child_id_contact_on_unique` (`child_id`,`contact_on`);

--
-- テーブルのインデックス `note_functions`
--
ALTER TABLE `note_functions`
  ADD PRIMARY KEY (`id`);

--
-- テーブルのインデックス `note_function_nursery`
--
ALTER TABLE `note_function_nursery`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `note_function_nursery_nursery_id_function_id_unique` (`nursery_id`,`function_id`),
  ADD KEY `note_function_nursery_function_id_foreign` (`function_id`);

--
-- テーブルのインデックス `note_main_users`
--
ALTER TABLE `note_main_users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `note_main_users_child_id_unique` (`child_id`);

--
-- テーブルのインデックス `note_nurture_schedule_changeable_days`
--
ALTER TABLE `note_nurture_schedule_changeable_days`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `note_nurture_schedule_changeable_days_nursery_id_unique` (`nursery_id`);

--
-- テーブルのインデックス `notices`
--
ALTER TABLE `notices`
  ADD PRIMARY KEY (`id`),
  ADD KEY `notices_author_id_foreign` (`author_id`),
  ADD KEY `notices_released_at_index` (`released_at`);

--
-- テーブルのインデックス `notice_attached_files`
--
ALTER TABLE `notice_attached_files`
  ADD PRIMARY KEY (`id`),
  ADD KEY `notice_attached_files_notice_id_foreign` (`notice_id`);

--
-- テーブルのインデックス `notice_questionnaire`
--
ALTER TABLE `notice_questionnaire`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `notice_questionnaire_notice_id_questionnaire_id_unique` (`notice_id`,`questionnaire_id`);

--
-- テーブルのインデックス `nursery_features`
--
ALTER TABLE `nursery_features`
  ADD PRIMARY KEY (`id`);

--
-- テーブルのインデックス `nursery_nursery_feature`
--
ALTER TABLE `nursery_nursery_feature`
  ADD PRIMARY KEY (`id`),
  ADD KEY `nursery_nursery_feature_nursery_id_foreign` (`nursery_id`),
  ADD KEY `nursery_nursery_feature_feature_id_foreign` (`feature_id`);

--
-- テーブルのインデックス `pool_attendances`
--
ALTER TABLE `pool_attendances`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `pool_attendances_family_contact_id_unique` (`family_contact_id`);

--
-- テーブルのインデックス `pool_terms`
--
ALTER TABLE `pool_terms`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `pool_terms_nursery_id_unique` (`nursery_id`);

--
-- テーブルのインデックス `reserved_child_notices`
--
ALTER TABLE `reserved_child_notices`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `reserved_child_notices_notice_id_child_id_unique` (`notice_id`,`child_id`),
  ADD KEY `reserved_child_notices_child_id_foreign` (`child_id`),
  ADD KEY `reserved_child_notices_nursery_id_foreign` (`nursery_id`);

--
-- テーブルのインデックス `r_children`
--
ALTER TABLE `r_children`
  ADD PRIMARY KEY (`uniq_id`),
  ADD UNIQUE KEY `r_children_link_type_link_id_child_id_unique` (`link_type`,`link_id`,`child_id`),
  ADD KEY `r_children_child_id_index` (`child_id`);

--
-- テーブルのインデックス `r_classes`
--
ALTER TABLE `r_classes`
  ADD PRIMARY KEY (`uniq_id`),
  ADD UNIQUE KEY `r_classes_link_type_link_id_class_id_unique` (`link_type`,`link_id`,`class_id`),
  ADD KEY `r_classes_class_id_index` (`class_id`);

--
-- テーブルのインデックス `r_companies`
--
ALTER TABLE `r_companies`
  ADD PRIMARY KEY (`uniq_id`),
  ADD UNIQUE KEY `r_companies_link_type_link_id_company_id_unique` (`link_type`,`link_id`,`company_id`);

--
-- テーブルのインデックス `r_employees`
--
ALTER TABLE `r_employees`
  ADD PRIMARY KEY (`uniq_id`),
  ADD UNIQUE KEY `r_employees_link_type_link_id_employee_id_unique` (`link_type`,`link_id`,`employee_id`),
  ADD KEY `r_employees_employee_id_index` (`employee_id`);

--
-- テーブルのインデックス `r_families`
--
ALTER TABLE `r_families`
  ADD PRIMARY KEY (`uniq_id`),
  ADD UNIQUE KEY `r_families_link_type_link_id_family_id_unique` (`link_type`,`link_id`,`family_id`),
  ADD KEY `r_families_family_id_index` (`family_id`);

--
-- テーブルのインデックス `r_nurseries`
--
ALTER TABLE `r_nurseries`
  ADD PRIMARY KEY (`uniq_id`),
  ADD UNIQUE KEY `r_nurseries_link_type_link_id_nursery_id_unique` (`link_type`,`link_id`,`nursery_id`),
  ADD KEY `r_nurseries_nursery_id_index` (`nursery_id`);

--
-- テーブルのインデックス `t_allergies`
--
ALTER TABLE `t_allergies`
  ADD PRIMARY KEY (`allergy_id`);

--
-- テーブルのインデックス `t_allergy_manages`
--
ALTER TABLE `t_allergy_manages`
  ADD PRIMARY KEY (`manage_id`);

--
-- テーブルのインデックス `t_approved_business_logs`
--
ALTER TABLE `t_approved_business_logs`
  ADD PRIMARY KEY (`id`);

--
-- テーブルのインデックス `t_approved_daily_plans`
--
ALTER TABLE `t_approved_daily_plans`
  ADD PRIMARY KEY (`id`);

--
-- テーブルのインデックス `t_approved_developmental_records`
--
ALTER TABLE `t_approved_developmental_records`
  ADD PRIMARY KEY (`id`);

--
-- テーブルのインデックス `t_approved_incident_reports`
--
ALTER TABLE `t_approved_incident_reports`
  ADD PRIMARY KEY (`id`);

--
-- テーブルのインデックス `t_approved_meal_inspection_records`
--
ALTER TABLE `t_approved_meal_inspection_records`
  ADD PRIMARY KEY (`id`);

--
-- テーブルのインデックス `t_approved_monthly_plans`
--
ALTER TABLE `t_approved_monthly_plans`
  ADD PRIMARY KEY (`id`);

--
-- テーブルのインデックス `t_approved_nurture_diaries`
--
ALTER TABLE `t_approved_nurture_diaries`
  ADD PRIMARY KEY (`id`);

--
-- テーブルのインデックス `t_approved_personal_records`
--
ALTER TABLE `t_approved_personal_records`
  ADD PRIMARY KEY (`id`);

--
-- テーブルのインデックス `t_approved_weekly_plans`
--
ALTER TABLE `t_approved_weekly_plans`
  ADD PRIMARY KEY (`id`);

--
-- テーブルのインデックス `t_approved_yearly_plans`
--
ALTER TABLE `t_approved_yearly_plans`
  ADD PRIMARY KEY (`id`);

--
-- テーブルのインデックス `t_attendances`
--
ALTER TABLE `t_attendances`
  ADD PRIMARY KEY (`attendance_id`),
  ADD KEY `t_attendances_employee_id_index` (`employee_id`),
  ADD KEY `t_attendances_work_day_index` (`work_day`);

--
-- テーブルのインデックス `t_attendance_details`
--
ALTER TABLE `t_attendance_details`
  ADD PRIMARY KEY (`attendance_detail_id`),
  ADD KEY `t_attendance_details_attendance_id_index` (`attendance_id`);

--
-- テーブルのインデックス `t_body_measuring`
--
ALTER TABLE `t_body_measuring`
  ADD PRIMARY KEY (`body_measuring_id`),
  ADD KEY `t_body_measuring_child_id_index` (`child_id`),
  ADD KEY `t_body_measuring_date_index` (`date`);

--
-- テーブルのインデックス `t_business_logs`
--
ALTER TABLE `t_business_logs`
  ADD PRIMARY KEY (`log_id`);

--
-- テーブルのインデックス `t_business_log_manages`
--
ALTER TABLE `t_business_log_manages`
  ADD PRIMARY KEY (`manage_id`),
  ADD KEY `t_business_log_manages_log_id_index` (`log_id`);

--
-- テーブルのインデックス `t_child_attendances`
--
ALTER TABLE `t_child_attendances`
  ADD PRIMARY KEY (`child_attendance_id`),
  ADD KEY `t_child_attendances_child_id_index` (`child_id`),
  ADD KEY `t_child_attendances_school_day_index` (`school_day`);

--
-- テーブルのインデックス `t_child_contract_times`
--
ALTER TABLE `t_child_contract_times`
  ADD PRIMARY KEY (`id`);

--
-- テーブルのインデックス `t_child_extention_charges`
--
ALTER TABLE `t_child_extention_charges`
  ADD PRIMARY KEY (`manage_id`);

--
-- テーブルのインデックス `t_child_extention_settings`
--
ALTER TABLE `t_child_extention_settings`
  ADD PRIMARY KEY (`manage_id`);

--
-- テーブルのインデックス `t_child_goods`
--
ALTER TABLE `t_child_goods`
  ADD PRIMARY KEY (`manage_id`);

--
-- テーブルのインデックス `t_child_monthly_fees`
--
ALTER TABLE `t_child_monthly_fees`
  ADD PRIMARY KEY (`manage_id`);

--
-- テーブルのインデックス `t_child_nurture_amounts`
--
ALTER TABLE `t_child_nurture_amounts`
  ADD PRIMARY KEY (`child_nurture_amount_id`);

--
-- テーブルのインデックス `t_communication_board`
--
ALTER TABLE `t_communication_board`
  ADD PRIMARY KEY (`post_id`);

--
-- テーブルのインデックス `t_confirmation_status`
--
ALTER TABLE `t_confirmation_status`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `t_confirmation_status_post_id_employee_id_unique` (`post_id`,`employee_id`);

--
-- テーブルのインデックス `t_dailywork_configs`
--
ALTER TABLE `t_dailywork_configs`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `t_dailywork_configs_nursery_id_display_id_unique` (`nursery_id`,`display_id`);

--
-- テーブルのインデックス `t_daily_plans`
--
ALTER TABLE `t_daily_plans`
  ADD PRIMARY KEY (`plan_id`);

--
-- テーブルのインデックス `t_daily_plan_images`
--
ALTER TABLE `t_daily_plan_images`
  ADD PRIMARY KEY (`image_id`);

--
-- テーブルのインデックス `t_daily_plan_manages`
--
ALTER TABLE `t_daily_plan_manages`
  ADD PRIMARY KEY (`manage_id`);

--
-- テーブルのインデックス `t_developmental_records`
--
ALTER TABLE `t_developmental_records`
  ADD PRIMARY KEY (`record_id`);

--
-- テーブルのインデックス `t_developmental_record_manages`
--
ALTER TABLE `t_developmental_record_manages`
  ADD PRIMARY KEY (`manage_id`),
  ADD KEY `t_developmental_record_manages_record_id_index` (`record_id`);

--
-- テーブルのインデックス `t_extention_child_contract_times`
--
ALTER TABLE `t_extention_child_contract_times`
  ADD PRIMARY KEY (`id`),
  ADD KEY `t_extention_child_contract_times_child_id_index` (`child_id`);

--
-- テーブルのインデックス `t_healths`
--
ALTER TABLE `t_healths`
  ADD PRIMARY KEY (`health_id`);

--
-- テーブルのインデックス `t_health_defecation`
--
ALTER TABLE `t_health_defecation`
  ADD PRIMARY KEY (`manage_id`);

--
-- テーブルのインデックス `t_health_manages`
--
ALTER TABLE `t_health_manages`
  ADD PRIMARY KEY (`manage_id`),
  ADD KEY `t_health_manages_relation_id_index` (`relation_id`);

--
-- テーブルのインデックス `t_health_relations`
--
ALTER TABLE `t_health_relations`
  ADD PRIMARY KEY (`relation_id`);

--
-- テーブルのインデックス `t_health_thermometry`
--
ALTER TABLE `t_health_thermometry`
  ADD PRIMARY KEY (`manage_id`);

--
-- テーブルのインデックス `t_incident_reports`
--
ALTER TABLE `t_incident_reports`
  ADD PRIMARY KEY (`incident_id`);

--
-- テーブルのインデックス `t_incident_report_children`
--
ALTER TABLE `t_incident_report_children`
  ADD PRIMARY KEY (`manage_id`);

--
-- テーブルのインデックス `t_incident_report_images`
--
ALTER TABLE `t_incident_report_images`
  ADD PRIMARY KEY (`image_id`);

--
-- テーブルのインデックス `t_incident_report_manages`
--
ALTER TABLE `t_incident_report_manages`
  ADD PRIMARY KEY (`manage_id`);

--
-- テーブルのインデックス `t_meal_inspection_records`
--
ALTER TABLE `t_meal_inspection_records`
  ADD PRIMARY KEY (`record_id`);

--
-- テーブルのインデックス `t_meal_inspection_record_images`
--
ALTER TABLE `t_meal_inspection_record_images`
  ADD PRIMARY KEY (`image_id`);

--
-- テーブルのインデックス `t_meal_inspection_record_manages`
--
ALTER TABLE `t_meal_inspection_record_manages`
  ADD PRIMARY KEY (`manage_id`),
  ADD KEY `t_meal_inspection_record_manages_record_id_index` (`record_id`,`meal_category_id`,`item_id`);

--
-- テーブルのインデックス `t_messages`
--
ALTER TABLE `t_messages`
  ADD PRIMARY KEY (`message_id`);

--
-- テーブルのインデックス `t_message_recipients`
--
ALTER TABLE `t_message_recipients`
  ADD PRIMARY KEY (`message_recipient_id`),
  ADD UNIQUE KEY `t_message_recipients_child_id_mail_unique` (`child_id`,`mail`);

--
-- テーブルのインデックス `t_monthly_plans`
--
ALTER TABLE `t_monthly_plans`
  ADD PRIMARY KEY (`plan_id`);

--
-- テーブルのインデックス `t_monthly_plan_manages`
--
ALTER TABLE `t_monthly_plan_manages`
  ADD PRIMARY KEY (`manage_id`);

--
-- テーブルのインデックス `t_nursery_extention_charge_contract_price_settings`
--
ALTER TABLE `t_nursery_extention_charge_contract_price_settings`
  ADD PRIMARY KEY (`manage_id`);

--
-- テーブルのインデックス `t_nursery_extention_charge_contract_time_settings`
--
ALTER TABLE `t_nursery_extention_charge_contract_time_settings`
  ADD PRIMARY KEY (`manage_id`);

--
-- テーブルのインデックス `t_nursery_extention_charge_price_settings`
--
ALTER TABLE `t_nursery_extention_charge_price_settings`
  ADD PRIMARY KEY (`manage_id`);

--
-- テーブルのインデックス `t_nursery_extention_charge_time_settings`
--
ALTER TABLE `t_nursery_extention_charge_time_settings`
  ADD PRIMARY KEY (`manage_id`);

--
-- テーブルのインデックス `t_nursery_goods`
--
ALTER TABLE `t_nursery_goods`
  ADD PRIMARY KEY (`manage_id`);

--
-- テーブルのインデックス `t_nursery_invoice_settings`
--
ALTER TABLE `t_nursery_invoice_settings`
  ADD PRIMARY KEY (`manage_id`);

--
-- テーブルのインデックス `t_nursery_monthly_fees`
--
ALTER TABLE `t_nursery_monthly_fees`
  ADD PRIMARY KEY (`manage_id`);

--
-- テーブルのインデックス `t_nurture_diaries`
--
ALTER TABLE `t_nurture_diaries`
  ADD PRIMARY KEY (`diary_id`),
  ADD KEY `t_nurture_diaries_target_date_index` (`target_date`);

--
-- テーブルのインデックス `t_nurture_diary_images`
--
ALTER TABLE `t_nurture_diary_images`
  ADD PRIMARY KEY (`id`),
  ADD KEY `t_nurture_diary_images_image_id_foreign` (`image_id`),
  ADD KEY `t_nurture_diary_images_t_nurture_diary_id_foreign` (`t_nurture_diary_id`);

--
-- テーブルのインデックス `t_nurture_diary_manages`
--
ALTER TABLE `t_nurture_diary_manages`
  ADD PRIMARY KEY (`manage_id`),
  ADD KEY `t_nurture_diary_manages_diary_id_index` (`diary_id`);

--
-- テーブルのインデックス `t_nurture_schedules`
--
ALTER TABLE `t_nurture_schedules`
  ADD PRIMARY KEY (`nurture_schedule_id`),
  ADD KEY `t_nurture_schedules_school_day_deleted_at_child_id_index` (`school_day`,`deleted_at`,`child_id`),
  ADD KEY `t_nurture_schedules_child_id_index` (`child_id`);

--
-- テーブルのインデックス `t_optional_items`
--
ALTER TABLE `t_optional_items`
  ADD PRIMARY KEY (`optional_id`);

--
-- テーブルのインデックス `t_optional_item_patterns`
--
ALTER TABLE `t_optional_item_patterns`
  ADD PRIMARY KEY (`manage_id`);

--
-- テーブルのインデックス `t_optional_patterns`
--
ALTER TABLE `t_optional_patterns`
  ADD PRIMARY KEY (`pattern_id`);

--
-- テーブルのインデックス `t_personal_manages`
--
ALTER TABLE `t_personal_manages`
  ADD PRIMARY KEY (`manage_id`);

--
-- テーブルのインデックス `t_personal_records`
--
ALTER TABLE `t_personal_records`
  ADD PRIMARY KEY (`personal_record_id`);

--
-- テーブルのインデックス `t_shift_schedules`
--
ALTER TABLE `t_shift_schedules`
  ADD PRIMARY KEY (`shift_schedule_id`),
  ADD KEY `t_shift_schedules_date_deleted_at_index` (`date`,`deleted_at`);

--
-- テーブルのインデックス `t_shift_schedule_details`
--
ALTER TABLE `t_shift_schedule_details`
  ADD PRIMARY KEY (`detail_id`),
  ADD KEY `t_shift_schedule_details_t_shift_schedule_id_index` (`t_shift_schedule_id`);

--
-- テーブルのインデックス `t_sleeps`
--
ALTER TABLE `t_sleeps`
  ADD PRIMARY KEY (`sleep_id`),
  ADD KEY `t_sleeps_date_index` (`date`),
  ADD KEY `t_sleeps_nursery_id_index` (`nursery_id`);

--
-- テーブルのインデックス `t_sleep_class_climate_logs`
--
ALTER TABLE `t_sleep_class_climate_logs`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `t_sleep_class_climate_logs_sleep_id_class_id_unique` (`sleep_id`,`class_id`);

--
-- テーブルのインデックス `t_sleep_class_remarks`
--
ALTER TABLE `t_sleep_class_remarks`
  ADD PRIMARY KEY (`sleep_class_remark_id`),
  ADD UNIQUE KEY `t_sleep_class_remarks_sleep_id_class_id_unique` (`sleep_id`,`class_id`);

--
-- テーブルのインデックス `t_sleep_manages`
--
ALTER TABLE `t_sleep_manages`
  ADD PRIMARY KEY (`manage_id`),
  ADD KEY `t_sleep_manages_sleep_id_index` (`sleep_id`),
  ADD KEY `t_sleep_manages_child_id_index` (`child_id`),
  ADD KEY `t_sleep_manages_employee_id_index` (`employee_id`);

--
-- テーブルのインデックス `t_staffing_configs`
--
ALTER TABLE `t_staffing_configs`
  ADD PRIMARY KEY (`id`);

--
-- テーブルのインデックス `t_weathers`
--
ALTER TABLE `t_weathers`
  ADD PRIMARY KEY (`weather_id`);

--
-- テーブルのインデックス `t_weekly_plans`
--
ALTER TABLE `t_weekly_plans`
  ADD PRIMARY KEY (`plan_id`);

--
-- テーブルのインデックス `t_weekly_plan_headers`
--
ALTER TABLE `t_weekly_plan_headers`
  ADD PRIMARY KEY (`header_id`);

--
-- テーブルのインデックス `t_weekly_plan_manages`
--
ALTER TABLE `t_weekly_plan_manages`
  ADD PRIMARY KEY (`manage_id`),
  ADD KEY `t_weekly_plan_manages_plan_id_date_item_id_index` (`plan_id`,`date`,`item_id`);

--
-- テーブルのインデックス `t_yearly_plans`
--
ALTER TABLE `t_yearly_plans`
  ADD PRIMARY KEY (`plan_id`);

--
-- テーブルのインデックス `t_yearly_plan_manages`
--
ALTER TABLE `t_yearly_plan_manages`
  ADD PRIMARY KEY (`manage_id`);

--
-- ダンプしたテーブルの AUTO_INCREMENT
--

--
-- テーブルの AUTO_INCREMENT `attendance_changeable_times`
--
ALTER TABLE `attendance_changeable_times`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- テーブルの AUTO_INCREMENT `b_accident_items`
--
ALTER TABLE `b_accident_items`
  MODIFY `item_id` bigint UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '項目ID';

--
-- テーブルの AUTO_INCREMENT `b_accident_regist_categories`
--
ALTER TABLE `b_accident_regist_categories`
  MODIFY `classify_id` bigint UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '分類ID';

--
-- テーブルの AUTO_INCREMENT `b_business_log_items`
--
ALTER TABLE `b_business_log_items`
  MODIFY `item_id` bigint UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '項目ID';

--
-- テーブルの AUTO_INCREMENT `b_business_log_regist_categories`
--
ALTER TABLE `b_business_log_regist_categories`
  MODIFY `classify_id` bigint UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '分類ID';

--
-- テーブルの AUTO_INCREMENT `b_certified_personal_shift_templates`
--
ALTER TABLE `b_certified_personal_shift_templates`
  MODIFY `personal_shift_id` int UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '個人シフトID';

--
-- テーブルの AUTO_INCREMENT `b_certified_personal_shift_template_details`
--
ALTER TABLE `b_certified_personal_shift_template_details`
  MODIFY `personal_shift_detail_id` bigint UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '個人シフト詳細ID';

--
-- テーブルの AUTO_INCREMENT `b_certified_shift_templates`
--
ALTER TABLE `b_certified_shift_templates`
  MODIFY `shift_id` int UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'シフト管理ID';

--
-- テーブルの AUTO_INCREMENT `b_certified_shift_template_details`
--
ALTER TABLE `b_certified_shift_template_details`
  MODIFY `shift_detail_id` bigint UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'シフト詳細ID';

--
-- テーブルの AUTO_INCREMENT `b_children`
--
ALTER TABLE `b_children`
  MODIFY `child_id` int UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '児童ID';

--
-- テーブルの AUTO_INCREMENT `b_child_classes`
--
ALTER TABLE `b_child_classes`
  MODIFY `class_manage_id` int UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '所属クラス管理ID';

--
-- テーブルの AUTO_INCREMENT `b_child_department_histories`
--
ALTER TABLE `b_child_department_histories`
  MODIFY `history_id` int UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '履歴ID';

--
-- テーブルの AUTO_INCREMENT `b_child_monthly_fees`
--
ALTER TABLE `b_child_monthly_fees`
  MODIFY `manage_id` bigint UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '管理ID';

--
-- テーブルの AUTO_INCREMENT `b_child_support_terms`
--
ALTER TABLE `b_child_support_terms`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'ID';

--
-- テーブルの AUTO_INCREMENT `b_classes`
--
ALTER TABLE `b_classes`
  MODIFY `class_id` int UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'クラスID';

--
-- テーブルの AUTO_INCREMENT `b_configs`
--
ALTER TABLE `b_configs`
  MODIFY `config_id` bigint UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '設定ID';

--
-- テーブルの AUTO_INCREMENT `b_daily_plan_items`
--
ALTER TABLE `b_daily_plan_items`
  MODIFY `item_id` int UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '項目ID';

--
-- テーブルの AUTO_INCREMENT `b_daily_plan_regist_categories`
--
ALTER TABLE `b_daily_plan_regist_categories`
  MODIFY `classify_id` bigint UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '分類ID';

--
-- テーブルの AUTO_INCREMENT `b_developmental_record_categories`
--
ALTER TABLE `b_developmental_record_categories`
  MODIFY `item_id` bigint UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '領域ID';

--
-- テーブルの AUTO_INCREMENT `b_developmental_record_cate_regist_categories`
--
ALTER TABLE `b_developmental_record_cate_regist_categories`
  MODIFY `classify_id` bigint UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '分類ID';

--
-- テーブルの AUTO_INCREMENT `b_developmental_record_items`
--
ALTER TABLE `b_developmental_record_items`
  MODIFY `item_id` bigint UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '項目ID';

--
-- テーブルの AUTO_INCREMENT `b_developmental_record_item_regist_categories`
--
ALTER TABLE `b_developmental_record_item_regist_categories`
  MODIFY `classify_id` bigint UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '分類ID';

--
-- テーブルの AUTO_INCREMENT `b_employees`
--
ALTER TABLE `b_employees`
  MODIFY `employee_id` int UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '従業員ID';

--
-- テーブルの AUTO_INCREMENT `b_employee_department_histories`
--
ALTER TABLE `b_employee_department_histories`
  MODIFY `history_id` bigint UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '履歴ID';

--
-- テーブルの AUTO_INCREMENT `b_employee_qualifications`
--
ALTER TABLE `b_employee_qualifications`
  MODIFY `employee_qualification_id` int UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '紐付ID';

--
-- テーブルの AUTO_INCREMENT `b_employee_working_form_histories`
--
ALTER TABLE `b_employee_working_form_histories`
  MODIFY `history_id` bigint UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '履歴ID';

--
-- テーブルの AUTO_INCREMENT `b_events`
--
ALTER TABLE `b_events`
  MODIFY `event_id` int UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'イベントID';

--
-- テーブルの AUTO_INCREMENT `b_extention_charge_price_contract_settings`
--
ALTER TABLE `b_extention_charge_price_contract_settings`
  MODIFY `price_id` bigint UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '延長料金ID';

--
-- テーブルの AUTO_INCREMENT `b_extention_charge_price_settings`
--
ALTER TABLE `b_extention_charge_price_settings`
  MODIFY `price_id` bigint UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '延長料金ID';

--
-- テーブルの AUTO_INCREMENT `b_extention_charge_time_contract_settings`
--
ALTER TABLE `b_extention_charge_time_contract_settings`
  MODIFY `charge_id` bigint UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '延長料金ID';

--
-- テーブルの AUTO_INCREMENT `b_extention_charge_time_settings`
--
ALTER TABLE `b_extention_charge_time_settings`
  MODIFY `charge_id` bigint UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '延長料金ID';

--
-- テーブルの AUTO_INCREMENT `b_families`
--
ALTER TABLE `b_families`
  MODIFY `family_id` int UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '家族ID';

--
-- テーブルの AUTO_INCREMENT `b_fixed_phrases`
--
ALTER TABLE `b_fixed_phrases`
  MODIFY `phrase_id` int UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '管理ID';

--
-- テーブルの AUTO_INCREMENT `b_hourly_aggregation_configs`
--
ALTER TABLE `b_hourly_aggregation_configs`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'ID';

--
-- テーブルの AUTO_INCREMENT `b_ip_address_permissions`
--
ALTER TABLE `b_ip_address_permissions`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '連番';

--
-- テーブルの AUTO_INCREMENT `b_item_configs`
--
ALTER TABLE `b_item_configs`
  MODIFY `config_id` bigint UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '設定ID';

--
-- テーブルの AUTO_INCREMENT `b_meal_inspection_record_items`
--
ALTER TABLE `b_meal_inspection_record_items`
  MODIFY `item_id` bigint UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '入力項目ID';

--
-- テーブルの AUTO_INCREMENT `b_meal_inspection_record_item_regist_categories`
--
ALTER TABLE `b_meal_inspection_record_item_regist_categories`
  MODIFY `classify_id` bigint UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '分類ID';

--
-- テーブルの AUTO_INCREMENT `b_meal_inspection_record_meal_categories`
--
ALTER TABLE `b_meal_inspection_record_meal_categories`
  MODIFY `item_id` bigint UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '食事種別ID';

--
-- テーブルの AUTO_INCREMENT `b_meal_inspection_record_meal_category_regist_categories`
--
ALTER TABLE `b_meal_inspection_record_meal_category_regist_categories`
  MODIFY `classify_id` bigint UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '分類ID';

--
-- テーブルの AUTO_INCREMENT `b_monthly_plan_items`
--
ALTER TABLE `b_monthly_plan_items`
  MODIFY `item_id` int UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '項目ID';

--
-- テーブルの AUTO_INCREMENT `b_monthly_plan_regist_categories`
--
ALTER TABLE `b_monthly_plan_regist_categories`
  MODIFY `classify_id` bigint UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '分類ID';

--
-- テーブルの AUTO_INCREMENT `b_near_hit_items`
--
ALTER TABLE `b_near_hit_items`
  MODIFY `item_id` bigint UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '項目ID';

--
-- テーブルの AUTO_INCREMENT `b_near_hit_regist_categories`
--
ALTER TABLE `b_near_hit_regist_categories`
  MODIFY `classify_id` bigint UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '分類ID';

--
-- テーブルの AUTO_INCREMENT `b_nurseries`
--
ALTER TABLE `b_nurseries`
  MODIFY `nursery_id` int UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '保育所ID';

--
-- テーブルの AUTO_INCREMENT `b_nursery_bank_accounts`
--
ALTER TABLE `b_nursery_bank_accounts`
  MODIFY `account_id` bigint UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '口座ID';

--
-- テーブルの AUTO_INCREMENT `b_nursery_goods`
--
ALTER TABLE `b_nursery_goods`
  MODIFY `goods_id` bigint UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '物品ID';

--
-- テーブルの AUTO_INCREMENT `b_nursery_histories`
--
ALTER TABLE `b_nursery_histories`
  MODIFY `history_id` bigint UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '履歴ID';

--
-- テーブルの AUTO_INCREMENT `b_nursery_monthly_fees`
--
ALTER TABLE `b_nursery_monthly_fees`
  MODIFY `fee_id` bigint UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '月極金額ID';

--
-- テーブルの AUTO_INCREMENT `b_nurture_diary_items`
--
ALTER TABLE `b_nurture_diary_items`
  MODIFY `item_id` int UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '項目ID';

--
-- テーブルの AUTO_INCREMENT `b_nurture_diary_regist_categories`
--
ALTER TABLE `b_nurture_diary_regist_categories`
  MODIFY `classify_id` bigint UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '分類ID';

--
-- テーブルの AUTO_INCREMENT `b_optional_item_items`
--
ALTER TABLE `b_optional_item_items`
  MODIFY `item_id` bigint UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '項目ID';

--
-- テーブルの AUTO_INCREMENT `b_optional_item_regist_categories`
--
ALTER TABLE `b_optional_item_regist_categories`
  MODIFY `manage_id` bigint UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '管理ID';

--
-- テーブルの AUTO_INCREMENT `b_personal_items`
--
ALTER TABLE `b_personal_items`
  MODIFY `item_id` int UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '項目ID';

--
-- テーブルの AUTO_INCREMENT `b_personal_regist_categories`
--
ALTER TABLE `b_personal_regist_categories`
  MODIFY `classify_id` bigint UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '分類ID';

--
-- テーブルの AUTO_INCREMENT `b_personal_shift_templates`
--
ALTER TABLE `b_personal_shift_templates`
  MODIFY `personal_shift_id` int UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '個人シフトID';

--
-- テーブルの AUTO_INCREMENT `b_shift_templates`
--
ALTER TABLE `b_shift_templates`
  MODIFY `shift_id` int UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'シフト管理ID';

--
-- テーブルの AUTO_INCREMENT `b_staffings`
--
ALTER TABLE `b_staffings`
  MODIFY `staffing_id` int UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '人員配置ID';

--
-- テーブルの AUTO_INCREMENT `b_term_items`
--
ALTER TABLE `b_term_items`
  MODIFY `item_id` bigint UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'マスタ項目ID';

--
-- テーブルの AUTO_INCREMENT `b_term_regist_categories`
--
ALTER TABLE `b_term_regist_categories`
  MODIFY `classify_id` bigint UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '分類ID';

--
-- テーブルの AUTO_INCREMENT `b_tokens`
--
ALTER TABLE `b_tokens`
  MODIFY `uniq_id` bigint UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '連番';

--
-- テーブルの AUTO_INCREMENT `b_users`
--
ALTER TABLE `b_users`
  MODIFY `user_id` int UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'ユーザーID';

--
-- テーブルの AUTO_INCREMENT `b_user_auths`
--
ALTER TABLE `b_user_auths`
  MODIFY `user_auth_id` int UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '紐付ID';

--
-- テーブルの AUTO_INCREMENT `b_weather_items`
--
ALTER TABLE `b_weather_items`
  MODIFY `weather_item_id` int UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '項目ID';

--
-- テーブルの AUTO_INCREMENT `b_weekly_plan_items`
--
ALTER TABLE `b_weekly_plan_items`
  MODIFY `item_id` int UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '項目ID';

--
-- テーブルの AUTO_INCREMENT `b_weekly_plan_regist_categories`
--
ALTER TABLE `b_weekly_plan_regist_categories`
  MODIFY `classify_id` bigint UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '分類ID';

--
-- テーブルの AUTO_INCREMENT `b_yearly_plan_items`
--
ALTER TABLE `b_yearly_plan_items`
  MODIFY `item_id` int UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '項目ID';

--
-- テーブルの AUTO_INCREMENT `b_yearly_plan_regist_categories`
--
ALTER TABLE `b_yearly_plan_regist_categories`
  MODIFY `classify_id` bigint UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '分類ID';

--
-- テーブルの AUTO_INCREMENT `child_attendances`
--
ALTER TABLE `child_attendances`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- テーブルの AUTO_INCREMENT `child_attendance_requests`
--
ALTER TABLE `child_attendance_requests`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- テーブルの AUTO_INCREMENT `child_attendance_statuses`
--
ALTER TABLE `child_attendance_statuses`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- テーブルの AUTO_INCREMENT `child_notice`
--
ALTER TABLE `child_notice`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- テーブルの AUTO_INCREMENT `class_notice`
--
ALTER TABLE `class_notice`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- テーブルの AUTO_INCREMENT `communication_board_attached_files`
--
ALTER TABLE `communication_board_attached_files`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- テーブルの AUTO_INCREMENT `diseases`
--
ALTER TABLE `diseases`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- テーブルの AUTO_INCREMENT `employee_broadcast_messages`
--
ALTER TABLE `employee_broadcast_messages`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- テーブルの AUTO_INCREMENT `employee_messages`
--
ALTER TABLE `employee_messages`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- テーブルの AUTO_INCREMENT `employee_message_images`
--
ALTER TABLE `employee_message_images`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- テーブルの AUTO_INCREMENT `employee_message_statuses`
--
ALTER TABLE `employee_message_statuses`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- テーブルの AUTO_INCREMENT `employee_orders`
--
ALTER TABLE `employee_orders`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- テーブルの AUTO_INCREMENT `failed_jobs`
--
ALTER TABLE `failed_jobs`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- テーブルの AUTO_INCREMENT `family_contacts`
--
ALTER TABLE `family_contacts`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- テーブルの AUTO_INCREMENT `family_defecations`
--
ALTER TABLE `family_defecations`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- テーブルの AUTO_INCREMENT `family_meals`
--
ALTER TABLE `family_meals`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- テーブルの AUTO_INCREMENT `family_messages`
--
ALTER TABLE `family_messages`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- テーブルの AUTO_INCREMENT `family_sleeps`
--
ALTER TABLE `family_sleeps`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- テーブルの AUTO_INCREMENT `family_thermometries`
--
ALTER TABLE `family_thermometries`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- テーブルの AUTO_INCREMENT `images`
--
ALTER TABLE `images`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- テーブルの AUTO_INCREMENT `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- テーブルの AUTO_INCREMENT `m_allergy_items`
--
ALTER TABLE `m_allergy_items`
  MODIFY `item_id` int UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '項目ID';

--
-- テーブルの AUTO_INCREMENT `m_functions`
--
ALTER TABLE `m_functions`
  MODIFY `function_id` int UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '機能ID';

--
-- テーブルの AUTO_INCREMENT `m_function_auths`
--
ALTER TABLE `m_function_auths`
  MODIFY `function_auth_id` int UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '機能権限ID';

--
-- テーブルの AUTO_INCREMENT `m_health_items`
--
ALTER TABLE `m_health_items`
  MODIFY `item_id` int UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '項目ID';

--
-- テーブルの AUTO_INCREMENT `note_contacts`
--
ALTER TABLE `note_contacts`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- テーブルの AUTO_INCREMENT `note_functions`
--
ALTER TABLE `note_functions`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- テーブルの AUTO_INCREMENT `note_function_nursery`
--
ALTER TABLE `note_function_nursery`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- テーブルの AUTO_INCREMENT `note_main_users`
--
ALTER TABLE `note_main_users`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- テーブルの AUTO_INCREMENT `note_nurture_schedule_changeable_days`
--
ALTER TABLE `note_nurture_schedule_changeable_days`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- テーブルの AUTO_INCREMENT `notices`
--
ALTER TABLE `notices`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- テーブルの AUTO_INCREMENT `notice_attached_files`
--
ALTER TABLE `notice_attached_files`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- テーブルの AUTO_INCREMENT `notice_questionnaire`
--
ALTER TABLE `notice_questionnaire`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- テーブルの AUTO_INCREMENT `nursery_features`
--
ALTER TABLE `nursery_features`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- テーブルの AUTO_INCREMENT `nursery_nursery_feature`
--
ALTER TABLE `nursery_nursery_feature`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- テーブルの AUTO_INCREMENT `pool_attendances`
--
ALTER TABLE `pool_attendances`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- テーブルの AUTO_INCREMENT `pool_terms`
--
ALTER TABLE `pool_terms`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- テーブルの AUTO_INCREMENT `reserved_child_notices`
--
ALTER TABLE `reserved_child_notices`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- テーブルの AUTO_INCREMENT `r_children`
--
ALTER TABLE `r_children`
  MODIFY `uniq_id` bigint UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '連番';

--
-- テーブルの AUTO_INCREMENT `r_classes`
--
ALTER TABLE `r_classes`
  MODIFY `uniq_id` bigint UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '連番';

--
-- テーブルの AUTO_INCREMENT `r_companies`
--
ALTER TABLE `r_companies`
  MODIFY `uniq_id` bigint UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '連番';

--
-- テーブルの AUTO_INCREMENT `r_employees`
--
ALTER TABLE `r_employees`
  MODIFY `uniq_id` bigint UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '連番';

--
-- テーブルの AUTO_INCREMENT `r_families`
--
ALTER TABLE `r_families`
  MODIFY `uniq_id` bigint UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '連番';

--
-- テーブルの AUTO_INCREMENT `r_nurseries`
--
ALTER TABLE `r_nurseries`
  MODIFY `uniq_id` bigint UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '連番';

--
-- テーブルの AUTO_INCREMENT `t_allergies`
--
ALTER TABLE `t_allergies`
  MODIFY `allergy_id` int UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'アレルギーID';

--
-- テーブルの AUTO_INCREMENT `t_allergy_manages`
--
ALTER TABLE `t_allergy_manages`
  MODIFY `manage_id` int UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '管理ID';

--
-- テーブルの AUTO_INCREMENT `t_approved_business_logs`
--
ALTER TABLE `t_approved_business_logs`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '承認済み園日誌ID';

--
-- テーブルの AUTO_INCREMENT `t_approved_daily_plans`
--
ALTER TABLE `t_approved_daily_plans`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '承認済み日案ID';

--
-- テーブルの AUTO_INCREMENT `t_approved_developmental_records`
--
ALTER TABLE `t_approved_developmental_records`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '承認済み発達記録ID';

--
-- テーブルの AUTO_INCREMENT `t_approved_incident_reports`
--
ALTER TABLE `t_approved_incident_reports`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '承認済みヒヤリハット・事故報告書ID';

--
-- テーブルの AUTO_INCREMENT `t_approved_meal_inspection_records`
--
ALTER TABLE `t_approved_meal_inspection_records`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '承認済み検食簿ID';

--
-- テーブルの AUTO_INCREMENT `t_approved_monthly_plans`
--
ALTER TABLE `t_approved_monthly_plans`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '承認済み月案ID';

--
-- テーブルの AUTO_INCREMENT `t_approved_nurture_diaries`
--
ALTER TABLE `t_approved_nurture_diaries`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '承認済み保育日誌ID';

--
-- テーブルの AUTO_INCREMENT `t_approved_personal_records`
--
ALTER TABLE `t_approved_personal_records`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '承認済み個人記録ID';

--
-- テーブルの AUTO_INCREMENT `t_approved_weekly_plans`
--
ALTER TABLE `t_approved_weekly_plans`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '承認済み週案ID';

--
-- テーブルの AUTO_INCREMENT `t_approved_yearly_plans`
--
ALTER TABLE `t_approved_yearly_plans`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '承認済み年間指導計画ID';

--
-- テーブルの AUTO_INCREMENT `t_attendances`
--
ALTER TABLE `t_attendances`
  MODIFY `attendance_id` int UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '勤怠管理ID';

--
-- テーブルの AUTO_INCREMENT `t_attendance_details`
--
ALTER TABLE `t_attendance_details`
  MODIFY `attendance_detail_id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- テーブルの AUTO_INCREMENT `t_body_measuring`
--
ALTER TABLE `t_body_measuring`
  MODIFY `body_measuring_id` int UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '身体測定ID';

--
-- テーブルの AUTO_INCREMENT `t_business_logs`
--
ALTER TABLE `t_business_logs`
  MODIFY `log_id` int UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '園日誌ID';

--
-- テーブルの AUTO_INCREMENT `t_business_log_manages`
--
ALTER TABLE `t_business_log_manages`
  MODIFY `manage_id` bigint UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '管理ID';

--
-- テーブルの AUTO_INCREMENT `t_child_attendances`
--
ALTER TABLE `t_child_attendances`
  MODIFY `child_attendance_id` bigint UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '登降園ID';

--
-- テーブルの AUTO_INCREMENT `t_child_contract_times`
--
ALTER TABLE `t_child_contract_times`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- テーブルの AUTO_INCREMENT `t_child_extention_charges`
--
ALTER TABLE `t_child_extention_charges`
  MODIFY `manage_id` bigint UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '管理ID';

--
-- テーブルの AUTO_INCREMENT `t_child_extention_settings`
--
ALTER TABLE `t_child_extention_settings`
  MODIFY `manage_id` bigint UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '管理ID';

--
-- テーブルの AUTO_INCREMENT `t_child_goods`
--
ALTER TABLE `t_child_goods`
  MODIFY `manage_id` bigint UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '管理ID';

--
-- テーブルの AUTO_INCREMENT `t_child_monthly_fees`
--
ALTER TABLE `t_child_monthly_fees`
  MODIFY `manage_id` bigint UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '管理ID';

--
-- テーブルの AUTO_INCREMENT `t_child_nurture_amounts`
--
ALTER TABLE `t_child_nurture_amounts`
  MODIFY `child_nurture_amount_id` int UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '児童毎保育量ID';

--
-- テーブルの AUTO_INCREMENT `t_communication_board`
--
ALTER TABLE `t_communication_board`
  MODIFY `post_id` bigint UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '投稿ID';

--
-- テーブルの AUTO_INCREMENT `t_confirmation_status`
--
ALTER TABLE `t_confirmation_status`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'ID';

--
-- テーブルの AUTO_INCREMENT `t_dailywork_configs`
--
ALTER TABLE `t_dailywork_configs`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'ID';

--
-- テーブルの AUTO_INCREMENT `t_daily_plans`
--
ALTER TABLE `t_daily_plans`
  MODIFY `plan_id` int UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '日案ID';

--
-- テーブルの AUTO_INCREMENT `t_daily_plan_images`
--
ALTER TABLE `t_daily_plan_images`
  MODIFY `image_id` int UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '管理ID';

--
-- テーブルの AUTO_INCREMENT `t_daily_plan_manages`
--
ALTER TABLE `t_daily_plan_manages`
  MODIFY `manage_id` int UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '管理ID';

--
-- テーブルの AUTO_INCREMENT `t_developmental_records`
--
ALTER TABLE `t_developmental_records`
  MODIFY `record_id` bigint UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '発達記録ID';

--
-- テーブルの AUTO_INCREMENT `t_developmental_record_manages`
--
ALTER TABLE `t_developmental_record_manages`
  MODIFY `manage_id` bigint UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '管理ID';

--
-- テーブルの AUTO_INCREMENT `t_extention_child_contract_times`
--
ALTER TABLE `t_extention_child_contract_times`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '管理ID';

--
-- テーブルの AUTO_INCREMENT `t_healths`
--
ALTER TABLE `t_healths`
  MODIFY `health_id` int UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '健康チェックID';

--
-- テーブルの AUTO_INCREMENT `t_health_defecation`
--
ALTER TABLE `t_health_defecation`
  MODIFY `manage_id` int UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '管理ID';

--
-- テーブルの AUTO_INCREMENT `t_health_manages`
--
ALTER TABLE `t_health_manages`
  MODIFY `manage_id` int UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '管理ID';

--
-- テーブルの AUTO_INCREMENT `t_health_relations`
--
ALTER TABLE `t_health_relations`
  MODIFY `relation_id` int UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '紐付ID';

--
-- テーブルの AUTO_INCREMENT `t_health_thermometry`
--
ALTER TABLE `t_health_thermometry`
  MODIFY `manage_id` int UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '管理ID';

--
-- テーブルの AUTO_INCREMENT `t_incident_reports`
--
ALTER TABLE `t_incident_reports`
  MODIFY `incident_id` bigint UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '報告書ID';

--
-- テーブルの AUTO_INCREMENT `t_incident_report_children`
--
ALTER TABLE `t_incident_report_children`
  MODIFY `manage_id` bigint UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '管理ID';

--
-- テーブルの AUTO_INCREMENT `t_incident_report_images`
--
ALTER TABLE `t_incident_report_images`
  MODIFY `image_id` bigint UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '管理ID';

--
-- テーブルの AUTO_INCREMENT `t_incident_report_manages`
--
ALTER TABLE `t_incident_report_manages`
  MODIFY `manage_id` bigint UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '管理ID';

--
-- テーブルの AUTO_INCREMENT `t_meal_inspection_records`
--
ALTER TABLE `t_meal_inspection_records`
  MODIFY `record_id` bigint UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '検食簿ID';

--
-- テーブルの AUTO_INCREMENT `t_meal_inspection_record_images`
--
ALTER TABLE `t_meal_inspection_record_images`
  MODIFY `image_id` bigint UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '画像ID';

--
-- テーブルの AUTO_INCREMENT `t_meal_inspection_record_manages`
--
ALTER TABLE `t_meal_inspection_record_manages`
  MODIFY `manage_id` bigint UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '管理ID';

--
-- テーブルの AUTO_INCREMENT `t_messages`
--
ALTER TABLE `t_messages`
  MODIFY `message_id` int UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'メッセージID';

--
-- テーブルの AUTO_INCREMENT `t_message_recipients`
--
ALTER TABLE `t_message_recipients`
  MODIFY `message_recipient_id` int UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '受信者ID';

--
-- テーブルの AUTO_INCREMENT `t_monthly_plans`
--
ALTER TABLE `t_monthly_plans`
  MODIFY `plan_id` int UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '月案ID';

--
-- テーブルの AUTO_INCREMENT `t_monthly_plan_manages`
--
ALTER TABLE `t_monthly_plan_manages`
  MODIFY `manage_id` int UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '管理ID';

--
-- テーブルの AUTO_INCREMENT `t_nursery_extention_charge_contract_price_settings`
--
ALTER TABLE `t_nursery_extention_charge_contract_price_settings`
  MODIFY `manage_id` bigint UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '管理ID';

--
-- テーブルの AUTO_INCREMENT `t_nursery_extention_charge_contract_time_settings`
--
ALTER TABLE `t_nursery_extention_charge_contract_time_settings`
  MODIFY `manage_id` bigint UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '管理ID';

--
-- テーブルの AUTO_INCREMENT `t_nursery_extention_charge_price_settings`
--
ALTER TABLE `t_nursery_extention_charge_price_settings`
  MODIFY `manage_id` bigint UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '管理ID';

--
-- テーブルの AUTO_INCREMENT `t_nursery_extention_charge_time_settings`
--
ALTER TABLE `t_nursery_extention_charge_time_settings`
  MODIFY `manage_id` bigint UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '管理ID';

--
-- テーブルの AUTO_INCREMENT `t_nursery_goods`
--
ALTER TABLE `t_nursery_goods`
  MODIFY `manage_id` bigint UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '管理ID';

--
-- テーブルの AUTO_INCREMENT `t_nursery_invoice_settings`
--
ALTER TABLE `t_nursery_invoice_settings`
  MODIFY `manage_id` bigint UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '管理ID';

--
-- テーブルの AUTO_INCREMENT `t_nursery_monthly_fees`
--
ALTER TABLE `t_nursery_monthly_fees`
  MODIFY `manage_id` bigint UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '管理ID';

--
-- テーブルの AUTO_INCREMENT `t_nurture_diaries`
--
ALTER TABLE `t_nurture_diaries`
  MODIFY `diary_id` int UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '保育日誌ID';

--
-- テーブルの AUTO_INCREMENT `t_nurture_diary_images`
--
ALTER TABLE `t_nurture_diary_images`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- テーブルの AUTO_INCREMENT `t_nurture_diary_manages`
--
ALTER TABLE `t_nurture_diary_manages`
  MODIFY `manage_id` int UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '管理ID';

--
-- テーブルの AUTO_INCREMENT `t_nurture_schedules`
--
ALTER TABLE `t_nurture_schedules`
  MODIFY `nurture_schedule_id` bigint UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'スケジュールID';

--
-- テーブルの AUTO_INCREMENT `t_optional_items`
--
ALTER TABLE `t_optional_items`
  MODIFY `optional_id` bigint UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '管理ID';

--
-- テーブルの AUTO_INCREMENT `t_optional_item_patterns`
--
ALTER TABLE `t_optional_item_patterns`
  MODIFY `manage_id` bigint UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '管理ID';

--
-- テーブルの AUTO_INCREMENT `t_optional_patterns`
--
ALTER TABLE `t_optional_patterns`
  MODIFY `pattern_id` bigint UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '任意項目設定ID';

--
-- テーブルの AUTO_INCREMENT `t_personal_manages`
--
ALTER TABLE `t_personal_manages`
  MODIFY `manage_id` int UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '管理ID';

--
-- テーブルの AUTO_INCREMENT `t_personal_records`
--
ALTER TABLE `t_personal_records`
  MODIFY `personal_record_id` int UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '個人記録ID';

--
-- テーブルの AUTO_INCREMENT `t_shift_schedules`
--
ALTER TABLE `t_shift_schedules`
  MODIFY `shift_schedule_id` int UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'シフトスケジュールID';

--
-- テーブルの AUTO_INCREMENT `t_shift_schedule_details`
--
ALTER TABLE `t_shift_schedule_details`
  MODIFY `detail_id` bigint UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '履歴ID';

--
-- テーブルの AUTO_INCREMENT `t_sleeps`
--
ALTER TABLE `t_sleeps`
  MODIFY `sleep_id` int UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '睡眠チェックID';

--
-- テーブルの AUTO_INCREMENT `t_sleep_class_climate_logs`
--
ALTER TABLE `t_sleep_class_climate_logs`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- テーブルの AUTO_INCREMENT `t_sleep_class_remarks`
--
ALTER TABLE `t_sleep_class_remarks`
  MODIFY `sleep_class_remark_id` int UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '睡眠チェッククラス備考ID';

--
-- テーブルの AUTO_INCREMENT `t_sleep_manages`
--
ALTER TABLE `t_sleep_manages`
  MODIFY `manage_id` int UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '管理ID';

--
-- テーブルの AUTO_INCREMENT `t_staffing_configs`
--
ALTER TABLE `t_staffing_configs`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- テーブルの AUTO_INCREMENT `t_weathers`
--
ALTER TABLE `t_weathers`
  MODIFY `weather_id` int UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '天気ID';

--
-- テーブルの AUTO_INCREMENT `t_weekly_plans`
--
ALTER TABLE `t_weekly_plans`
  MODIFY `plan_id` int UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '週案ID';

--
-- テーブルの AUTO_INCREMENT `t_weekly_plan_headers`
--
ALTER TABLE `t_weekly_plan_headers`
  MODIFY `header_id` int UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '通し番号';

--
-- テーブルの AUTO_INCREMENT `t_weekly_plan_manages`
--
ALTER TABLE `t_weekly_plan_manages`
  MODIFY `manage_id` int UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '管理ID';

--
-- テーブルの AUTO_INCREMENT `t_yearly_plans`
--
ALTER TABLE `t_yearly_plans`
  MODIFY `plan_id` int UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '年間指導計画ID';

--
-- テーブルの AUTO_INCREMENT `t_yearly_plan_manages`
--
ALTER TABLE `t_yearly_plan_manages`
  MODIFY `manage_id` int UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '管理ID';

--
-- ダンプしたテーブルの制約
--

--
-- テーブルの制約 `attendance_changeable_times`
--
ALTER TABLE `attendance_changeable_times`
  ADD CONSTRAINT `attendance_changeable_times_nursery_id_foreign` FOREIGN KEY (`nursery_id`) REFERENCES `b_nurseries` (`nursery_id`);

--
-- テーブルの制約 `child_attendances`
--
ALTER TABLE `child_attendances`
  ADD CONSTRAINT `child_attendances_attendance_status_id_foreign` FOREIGN KEY (`attendance_status_id`) REFERENCES `child_attendance_statuses` (`id`),
  ADD CONSTRAINT `child_attendances_child_id_foreign` FOREIGN KEY (`child_id`) REFERENCES `b_children` (`child_id`);

--
-- テーブルの制約 `child_attendance_requests`
--
ALTER TABLE `child_attendance_requests`
  ADD CONSTRAINT `child_attendance_requests_attendance_status_id_foreign` FOREIGN KEY (`attendance_status_id`) REFERENCES `child_attendance_statuses` (`id`),
  ADD CONSTRAINT `child_attendance_requests_child_id_foreign` FOREIGN KEY (`child_id`) REFERENCES `b_children` (`child_id`),
  ADD CONSTRAINT `child_attendance_requests_read_employee_id_foreign` FOREIGN KEY (`read_employee_id`) REFERENCES `b_employees` (`employee_id`);

--
-- テーブルの制約 `child_notice`
--
ALTER TABLE `child_notice`
  ADD CONSTRAINT `child_notice_child_id_foreign` FOREIGN KEY (`child_id`) REFERENCES `b_children` (`child_id`),
  ADD CONSTRAINT `child_notice_notice_id_foreign` FOREIGN KEY (`notice_id`) REFERENCES `notices` (`id`);

--
-- テーブルの制約 `class_notice`
--
ALTER TABLE `class_notice`
  ADD CONSTRAINT `class_notice_class_id_foreign` FOREIGN KEY (`class_id`) REFERENCES `b_classes` (`class_id`),
  ADD CONSTRAINT `class_notice_notice_id_foreign` FOREIGN KEY (`notice_id`) REFERENCES `notices` (`id`);

--
-- テーブルの制約 `communication_board_attached_files`
--
ALTER TABLE `communication_board_attached_files`
  ADD CONSTRAINT `attached_files_t_communication_board_id_foreign` FOREIGN KEY (`t_communication_board_id`) REFERENCES `t_communication_board` (`post_id`);

--
-- テーブルの制約 `employee_broadcast_messages`
--
ALTER TABLE `employee_broadcast_messages`
  ADD CONSTRAINT `employee_broadcast_messages_nurture_diary_id_foreign` FOREIGN KEY (`nurture_diary_id`) REFERENCES `t_nurture_diaries` (`diary_id`);

--
-- テーブルの制約 `employee_messages`
--
ALTER TABLE `employee_messages`
  ADD CONSTRAINT `employee_messages_employee_id_foreign` FOREIGN KEY (`employee_id`) REFERENCES `b_employees` (`employee_id`),
  ADD CONSTRAINT `employee_messages_message_status_id_foreign` FOREIGN KEY (`message_status_id`) REFERENCES `employee_message_statuses` (`id`),
  ADD CONSTRAINT `employee_messages_note_contact_id_foreign` FOREIGN KEY (`note_contact_id`) REFERENCES `note_contacts` (`id`);

--
-- テーブルの制約 `employee_message_images`
--
ALTER TABLE `employee_message_images`
  ADD CONSTRAINT `employee_message_images_employee_message_id_foreign` FOREIGN KEY (`employee_message_id`) REFERENCES `employee_messages` (`id`),
  ADD CONSTRAINT `employee_message_images_image_id_foreign` FOREIGN KEY (`image_id`) REFERENCES `images` (`id`);

--
-- テーブルの制約 `family_contacts`
--
ALTER TABLE `family_contacts`
  ADD CONSTRAINT `family_contacts_note_contact_id_foreign` FOREIGN KEY (`note_contact_id`) REFERENCES `note_contacts` (`id`);

--
-- テーブルの制約 `family_defecations`
--
ALTER TABLE `family_defecations`
  ADD CONSTRAINT `family_defecations_category_id_foreign` FOREIGN KEY (`category_id`) REFERENCES `defecation_categories` (`id`),
  ADD CONSTRAINT `family_defecations_family_contact_id_foreign` FOREIGN KEY (`family_contact_id`) REFERENCES `family_contacts` (`id`),
  ADD CONSTRAINT `family_defecations_status_id_foreign` FOREIGN KEY (`status_id`) REFERENCES `defecation_statuses` (`id`);

--
-- テーブルの制約 `family_meals`
--
ALTER TABLE `family_meals`
  ADD CONSTRAINT `family_meals_category_id_foreign` FOREIGN KEY (`category_id`) REFERENCES `meal_categories` (`id`),
  ADD CONSTRAINT `family_meals_family_contact_id_foreign` FOREIGN KEY (`family_contact_id`) REFERENCES `family_contacts` (`id`);

--
-- テーブルの制約 `family_messages`
--
ALTER TABLE `family_messages`
  ADD CONSTRAINT `family_messages_family_contact_id_foreign` FOREIGN KEY (`family_contact_id`) REFERENCES `family_contacts` (`id`);

--
-- テーブルの制約 `family_sleeps`
--
ALTER TABLE `family_sleeps`
  ADD CONSTRAINT `family_sleeps_family_contact_id_foreign` FOREIGN KEY (`family_contact_id`) REFERENCES `family_contacts` (`id`);

--
-- テーブルの制約 `family_thermometries`
--
ALTER TABLE `family_thermometries`
  ADD CONSTRAINT `family_thermometries_family_contact_id_foreign` FOREIGN KEY (`family_contact_id`) REFERENCES `family_contacts` (`id`);

--
-- テーブルの制約 `note_contacts`
--
ALTER TABLE `note_contacts`
  ADD CONSTRAINT `note_contacts_child_id_foreign` FOREIGN KEY (`child_id`) REFERENCES `b_children` (`child_id`);

--
-- テーブルの制約 `note_function_nursery`
--
ALTER TABLE `note_function_nursery`
  ADD CONSTRAINT `note_function_nursery_function_id_foreign` FOREIGN KEY (`function_id`) REFERENCES `note_functions` (`id`),
  ADD CONSTRAINT `note_function_nursery_nursery_id_foreign` FOREIGN KEY (`nursery_id`) REFERENCES `b_nurseries` (`nursery_id`);

--
-- テーブルの制約 `note_main_users`
--
ALTER TABLE `note_main_users`
  ADD CONSTRAINT `note_main_users_child_id_foreign` FOREIGN KEY (`child_id`) REFERENCES `b_children` (`child_id`);

--
-- テーブルの制約 `note_nurture_schedule_changeable_days`
--
ALTER TABLE `note_nurture_schedule_changeable_days`
  ADD CONSTRAINT `note_nurture_schedule_changeable_days_nursery_id_foreign` FOREIGN KEY (`nursery_id`) REFERENCES `b_nurseries` (`nursery_id`);

--
-- テーブルの制約 `notices`
--
ALTER TABLE `notices`
  ADD CONSTRAINT `notices_author_id_foreign` FOREIGN KEY (`author_id`) REFERENCES `b_employees` (`employee_id`);

--
-- テーブルの制約 `notice_attached_files`
--
ALTER TABLE `notice_attached_files`
  ADD CONSTRAINT `notice_attached_files_notice_id_foreign` FOREIGN KEY (`notice_id`) REFERENCES `notices` (`id`);

--
-- テーブルの制約 `notice_questionnaire`
--
ALTER TABLE `notice_questionnaire`
  ADD CONSTRAINT `notice_questionnaire_notice_id_foreign` FOREIGN KEY (`notice_id`) REFERENCES `notices` (`id`);

--
-- テーブルの制約 `nursery_nursery_feature`
--
ALTER TABLE `nursery_nursery_feature`
  ADD CONSTRAINT `nursery_nursery_feature_feature_id_foreign` FOREIGN KEY (`feature_id`) REFERENCES `nursery_features` (`id`),
  ADD CONSTRAINT `nursery_nursery_feature_nursery_id_foreign` FOREIGN KEY (`nursery_id`) REFERENCES `b_nurseries` (`nursery_id`);

--
-- テーブルの制約 `pool_attendances`
--
ALTER TABLE `pool_attendances`
  ADD CONSTRAINT `pool_attendances_family_contact_id_foreign` FOREIGN KEY (`family_contact_id`) REFERENCES `family_contacts` (`id`);

--
-- テーブルの制約 `pool_terms`
--
ALTER TABLE `pool_terms`
  ADD CONSTRAINT `pool_terms_nursery_id_foreign` FOREIGN KEY (`nursery_id`) REFERENCES `b_nurseries` (`nursery_id`);

--
-- テーブルの制約 `reserved_child_notices`
--
ALTER TABLE `reserved_child_notices`
  ADD CONSTRAINT `reserved_child_notices_child_id_foreign` FOREIGN KEY (`child_id`) REFERENCES `b_children` (`child_id`),
  ADD CONSTRAINT `reserved_child_notices_notice_id_foreign` FOREIGN KEY (`notice_id`) REFERENCES `notices` (`id`),
  ADD CONSTRAINT `reserved_child_notices_nursery_id_foreign` FOREIGN KEY (`nursery_id`) REFERENCES `b_nurseries` (`nursery_id`);

--
-- テーブルの制約 `t_nurture_diary_images`
--
ALTER TABLE `t_nurture_diary_images`
  ADD CONSTRAINT `t_nurture_diary_images_image_id_foreign` FOREIGN KEY (`image_id`) REFERENCES `images` (`id`),
  ADD CONSTRAINT `t_nurture_diary_images_t_nurture_diary_id_foreign` FOREIGN KEY (`t_nurture_diary_id`) REFERENCES `t_nurture_diaries` (`diary_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
