-- phpMyAdmin SQL Dump
-- version 5.2.2
-- https://www.phpmyadmin.net/
--
-- ホスト: db_hoisys
-- 生成日時: 2025 年 7 月 10 日 01:07
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
-- データベース: `management`
--

-- --------------------------------------------------------

--
-- テーブルの構造 `activities`
--

CREATE TABLE `activities` (
  `id` int UNSIGNED NOT NULL,
  `text` varchar(255) COLLATE utf8mb4_general_ci NOT NULL COMMENT '本文',
  `facility_id` int UNSIGNED NOT NULL COMMENT '施設id',
  `image_uuid` char(36) COLLATE utf8mb4_general_ci NOT NULL COMMENT '拡張子を除いたファイル名',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `photographed_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='活動';

-- --------------------------------------------------------

--
-- テーブルの構造 `activity_childcare_activity`
--

CREATE TABLE `activity_childcare_activity` (
  `id` int UNSIGNED NOT NULL,
  `activity_id` int UNSIGNED NOT NULL COMMENT '活動id',
  `childcare_activity_id` int UNSIGNED NOT NULL COMMENT '保育活動id',
  `display_order` int NOT NULL COMMENT '表示順',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='活動-保育活動中間テーブル';

-- --------------------------------------------------------

--
-- テーブルの構造 `answers`
--

CREATE TABLE `answers` (
  `id` int UNSIGNED NOT NULL,
  `question_id` int UNSIGNED NOT NULL COMMENT '質問ID',
  `respondent_id` int UNSIGNED NOT NULL COMMENT '回答者ID',
  `text` json DEFAULT NULL COMMENT '回答文',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- テーブルの構造 `archives`
--

CREATE TABLE `archives` (
  `id` int UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_general_ci NOT NULL COMMENT '名前',
  `memo` varchar(255) COLLATE utf8mb4_general_ci NOT NULL COMMENT 'メモ',
  `is_restricted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '権限を設定',
  `facility_id` int UNSIGNED NOT NULL COMMENT '施設id',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='アーカイブ';

-- --------------------------------------------------------

--
-- テーブルの構造 `archive_file`
--

CREATE TABLE `archive_file` (
  `id` int UNSIGNED NOT NULL,
  `archive_id` int UNSIGNED NOT NULL COMMENT 'アーカイブid',
  `file_id` int UNSIGNED NOT NULL COMMENT 'ファイルid',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='アーカイブとファイルの中間テーブル';

-- --------------------------------------------------------

--
-- テーブルの構造 `archive_permissions`
--

CREATE TABLE `archive_permissions` (
  `id` int UNSIGNED NOT NULL,
  `archive_id` int UNSIGNED NOT NULL COMMENT 'アーカイブid',
  `archive_permission_level_id` int UNSIGNED NOT NULL COMMENT '権限id',
  `employee_id` int UNSIGNED NOT NULL COMMENT '従業員id',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='アーカイブの権限';

-- --------------------------------------------------------

--
-- テーブルの構造 `archive_permission_levels`
--

CREATE TABLE `archive_permission_levels` (
  `id` int UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_general_ci NOT NULL COMMENT '権限名',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='アーカイブの権限名';

-- --------------------------------------------------------

--
-- テーブルの構造 `bank_account_types`
--

CREATE TABLE `bank_account_types` (
  `id` int UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_general_ci NOT NULL COMMENT '預金種目名: 普通 当座'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='預金種目マスタ';

-- --------------------------------------------------------

--
-- テーブルの構造 `bookings`
--

CREATE TABLE `bookings` (
  `reservation_requiry_number` varchar(80) COLLATE utf8mb4_general_ci NOT NULL COMMENT '予約番号',
  `requiry_reception_datetime` datetime DEFAULT NULL COMMENT '申請受付日時',
  `reservation_requiry_status` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '見学予約申請ステータス',
  `status_update_datetime` datetime DEFAULT NULL COMMENT '見学予約申請ステータス更新日時',
  `message_from_facility` text COLLATE utf8mb4_general_ci COMMENT '保護者への返信コメント',
  `booking_url` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '予約情報URL',
  `facility_number` varchar(40) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '事業所番号',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- テーブルの構造 `booking_responses`
--

CREATE TABLE `booking_responses` (
  `id` bigint UNSIGNED NOT NULL,
  `status_code` int NOT NULL COMMENT 'HTTPステータスコード',
  `response` longtext COLLATE utf8mb4_general_ci NOT NULL COMMENT 'APIのレスポンス',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- テーブルの構造 `childcare_activities`
--

CREATE TABLE `childcare_activities` (
  `id` int UNSIGNED NOT NULL,
  `title` varchar(255) COLLATE utf8mb4_general_ci NOT NULL COMMENT 'タイトル',
  `subtitle` varchar(255) COLLATE utf8mb4_general_ci NOT NULL COMMENT 'サブタイトル',
  `remarks` varchar(255) COLLATE utf8mb4_general_ci NOT NULL COMMENT '備考',
  `facility_id` int UNSIGNED NOT NULL COMMENT '施設id',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='保育活動（ドキュメンテーション）';

-- --------------------------------------------------------

--
-- テーブルの構造 `children`
--

CREATE TABLE `children` (
  `id` int UNSIGNED NOT NULL,
  `facility_id` int UNSIGNED NOT NULL COMMENT '施設id',
  `bchild_id` int NOT NULL COMMENT '従来の園児情報id',
  `family_name` varchar(50) COLLATE utf8mb4_general_ci NOT NULL COMMENT '姓',
  `given_name` varchar(50) COLLATE utf8mb4_general_ci NOT NULL COMMENT '名',
  `family_name_kana` varchar(50) COLLATE utf8mb4_general_ci NOT NULL COMMENT '姓カナ',
  `given_name_kana` varchar(50) COLLATE utf8mb4_general_ci NOT NULL COMMENT '名カナ',
  `gender` tinyint NOT NULL COMMENT '性別',
  `birthday` date NOT NULL COMMENT '生年月日',
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `admission_on` date NOT NULL,
  `leaving_on` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='施設に所属する児童一覧';

-- --------------------------------------------------------

--
-- テーブルの構造 `child_classroom`
--

CREATE TABLE `child_classroom` (
  `id` int UNSIGNED NOT NULL,
  `child_id` int UNSIGNED NOT NULL COMMENT '児童id',
  `classroom_id` int UNSIGNED NOT NULL COMMENT 'クラスid',
  `start_on` date NOT NULL COMMENT '開始日',
  `end_on` date NOT NULL COMMENT '終了日',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='クラスと園児紐付け中間テーブル';

-- --------------------------------------------------------

--
-- テーブルの構造 `child_direct_debit_request`
--

CREATE TABLE `child_direct_debit_request` (
  `id` int UNSIGNED NOT NULL,
  `child_id` int UNSIGNED NOT NULL COMMENT '児童id',
  `direct_debit_request_id` int UNSIGNED NOT NULL COMMENT '振替元口座id',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='振替対象の児童一覧';

-- --------------------------------------------------------

--
-- テーブルの構造 `child_meals`
--

CREATE TABLE `child_meals` (
  `id` int UNSIGNED NOT NULL,
  `class_meal_id` int UNSIGNED NOT NULL COMMENT 'クラスの食事のid',
  `child_id` int UNSIGNED NOT NULL COMMENT '児童のid',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- テーブルの構造 `choices`
--

CREATE TABLE `choices` (
  `id` int UNSIGNED NOT NULL,
  `question_id` int UNSIGNED NOT NULL COMMENT '質問ID',
  `text` varchar(255) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '選択肢',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- テーブルの構造 `classrooms`
--

CREATE TABLE `classrooms` (
  `id` int UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_general_ci NOT NULL COMMENT '名称',
  `facility_id` int UNSIGNED NOT NULL COMMENT '施設id',
  `bclass_id` int NOT NULL COMMENT '従来のクラスidと連携するためのid',
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='クラス名';

-- --------------------------------------------------------

--
-- テーブルの構造 `classroom_meal_remarks`
--

CREATE TABLE `classroom_meal_remarks` (
  `id` int UNSIGNED NOT NULL,
  `classroom_id` int UNSIGNED NOT NULL COMMENT 'クラスID',
  `eat_on` date NOT NULL COMMENT '食べた日',
  `meal_type` varchar(255) COLLATE utf8mb4_general_ci NOT NULL COMMENT '食事のタイプ',
  `remark` varchar(255) COLLATE utf8mb4_general_ci NOT NULL COMMENT 'コメント',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- テーブルの構造 `class_meals`
--

CREATE TABLE `class_meals` (
  `id` int UNSIGNED NOT NULL,
  `classroom_id` int UNSIGNED NOT NULL,
  `date` date NOT NULL COMMENT '日付',
  `remark` text COLLATE utf8mb4_general_ci NOT NULL COMMENT '備考',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- ビュー用の代替構造 `connections`
-- (実際のビューを参照するには下にあります)
--
CREATE TABLE `connections` (
`dbname` varchar(10)
,`id` int unsigned
);

-- --------------------------------------------------------

--
-- テーブルの構造 `corporations`
--

CREATE TABLE `corporations` (
  `id` int UNSIGNED NOT NULL,
  `code` varchar(10) COLLATE utf8mb4_general_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `name` varchar(255) COLLATE utf8mb4_general_ci NOT NULL COMMENT '企業名',
  `nursery_num` int NOT NULL COMMENT '作成可能な施設数の上限',
  `memo` varchar(255) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '社内用メモ',
  `status` int NOT NULL DEFAULT '0' COMMENT '契約状況 0:契約中 1:解約',
  `type` int NOT NULL DEFAULT '0' COMMENT '0:リアル 1:サンプル 2:キャスレー',
  `managed_name` varchar(255) COLLATE utf8mb4_general_ci NOT NULL COMMENT '管理用の法人名'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='法人';

-- --------------------------------------------------------

--
-- テーブルの構造 `direct_debits`
--

CREATE TABLE `direct_debits` (
  `id` int UNSIGNED NOT NULL,
  `facility_id` int UNSIGNED NOT NULL COMMENT '施設id',
  `account_type_id` int UNSIGNED NOT NULL COMMENT '預金種目id',
  `payment_number_request_status_id` int UNSIGNED NOT NULL COMMENT '口座の枝番号申請ステータスid',
  `contract_number` int NOT NULL COMMENT '契約番号（1契約につき、枝番号を1~999まで発行できる）',
  `payment_number` int NOT NULL COMMENT '枝番号',
  `bank_name` varchar(255) COLLATE utf8mb4_general_ci NOT NULL COMMENT '銀行名',
  `bank_name_kana` varchar(255) COLLATE utf8mb4_general_ci NOT NULL COMMENT '銀行名カナ',
  `bank_code` varchar(255) COLLATE utf8mb4_general_ci NOT NULL COMMENT '金融機関コード',
  `branch_name` varchar(255) COLLATE utf8mb4_general_ci NOT NULL COMMENT '支店名',
  `branch_name_kana` varchar(255) COLLATE utf8mb4_general_ci NOT NULL COMMENT '支店名カナ',
  `branch_code` varchar(255) COLLATE utf8mb4_general_ci NOT NULL COMMENT '支店コード',
  `account_name` varchar(255) COLLATE utf8mb4_general_ci NOT NULL COMMENT '口座名義人',
  `account_name_kana` varchar(255) COLLATE utf8mb4_general_ci NOT NULL COMMENT '口座名義人カナ',
  `account_code` varchar(255) COLLATE utf8mb4_general_ci NOT NULL COMMENT '口座番号',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='施設が保有する振替先の口座';

-- --------------------------------------------------------

--
-- テーブルの構造 `direct_debit_requests`
--

CREATE TABLE `direct_debit_requests` (
  `id` int UNSIGNED NOT NULL,
  `direct_debit_id` int UNSIGNED NOT NULL COMMENT '振替先口座id',
  `account_type_id` int UNSIGNED NOT NULL COMMENT '預金種目id',
  `bank_name` varchar(255) COLLATE utf8mb4_general_ci NOT NULL COMMENT '銀行名',
  `bank_name_kana` varchar(255) COLLATE utf8mb4_general_ci NOT NULL COMMENT '銀行名カナ',
  `bank_code` varchar(255) COLLATE utf8mb4_general_ci NOT NULL COMMENT '金融機関コード',
  `branch_name` varchar(255) COLLATE utf8mb4_general_ci NOT NULL COMMENT '支店名',
  `branch_name_kana` varchar(255) COLLATE utf8mb4_general_ci NOT NULL COMMENT '支店名カナ',
  `branch_code` varchar(255) COLLATE utf8mb4_general_ci NOT NULL COMMENT '金融機関コード',
  `account_name` varchar(255) COLLATE utf8mb4_general_ci NOT NULL COMMENT '口座名義人',
  `account_name_kana` varchar(255) COLLATE utf8mb4_general_ci NOT NULL COMMENT '口座名義人カナ',
  `account_code` varchar(255) COLLATE utf8mb4_general_ci NOT NULL COMMENT '口座番号',
  `is_enabled` tinyint(1) NOT NULL COMMENT '口座振替の要否',
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='施設利用者が保有する振替元の口座';

-- --------------------------------------------------------

--
-- テーブルの構造 `direct_debit_transactions`
--

CREATE TABLE `direct_debit_transactions` (
  `id` int UNSIGNED NOT NULL,
  `billing_on` date NOT NULL COMMENT '請求月',
  `direct_debit_request_id` int UNSIGNED NOT NULL COMMENT '振替元口座id',
  `account_type_id` int UNSIGNED DEFAULT NULL COMMENT '当月の請求金額入力が締め切られた時点で登録されていた振替元口座の預金種目id',
  `bank_code` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '当月の請求金額入力が締め切られた時点で登録されていた振替元口座の金融機関コード',
  `branch_code` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '当月の請求金額入力が締め切られた時点で登録されていた振替元口座の支店コード',
  `account_code` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '当月の請求金額入力が締め切られた時点で登録されていた振替元口座の口座番号',
  `child_id` int UNSIGNED NOT NULL COMMENT '児童id',
  `amount` int NOT NULL COMMENT '請求金額',
  `remarks` varchar(255) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '備考',
  `return_code` int DEFAULT NULL COMMENT '振替結果コード',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='口座振替トランザクション';

-- --------------------------------------------------------

--
-- テーブルの構造 `direct_debit_transaction_return_codes`
--

CREATE TABLE `direct_debit_transaction_return_codes` (
  `id` int UNSIGNED NOT NULL,
  `code` int NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `is_success` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='振替結果コードマスタ';

-- --------------------------------------------------------

--
-- テーブルの構造 `employees`
--

CREATE TABLE `employees` (
  `id` int UNSIGNED NOT NULL,
  `corporation_id` int UNSIGNED NOT NULL COMMENT '法人id',
  `bemployee_id` int NOT NULL COMMENT '従来の従業員情報id',
  `family_name` varchar(50) COLLATE utf8mb4_general_ci NOT NULL COMMENT '姓',
  `given_name` varchar(50) COLLATE utf8mb4_general_ci NOT NULL COMMENT '名',
  `family_name_kana` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '姓カナ',
  `given_name_kana` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '名カナ',
  `birthday` date DEFAULT NULL COMMENT '生年月日',
  `admission_on` date NOT NULL COMMENT '入所日',
  `leaving_on` date DEFAULT NULL COMMENT '退所日',
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `gender` int DEFAULT NULL COMMENT '性別'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='従業員テーブル';

-- --------------------------------------------------------

--
-- テーブルの構造 `employee_facility`
--

CREATE TABLE `employee_facility` (
  `id` int UNSIGNED NOT NULL,
  `employee_id` int UNSIGNED NOT NULL COMMENT '従業員id',
  `facility_id` int UNSIGNED NOT NULL COMMENT '施設id',
  `start_on` date NOT NULL COMMENT '開始日',
  `end_on` date DEFAULT NULL COMMENT '終了日',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='従業員と施設の中間テーブル';

-- --------------------------------------------------------

--
-- テーブルの構造 `facilities`
--

CREATE TABLE `facilities` (
  `id` int UNSIGNED NOT NULL,
  `corporation_id` int UNSIGNED NOT NULL COMMENT '法人id',
  `name` varchar(255) COLLATE utf8mb4_general_ci NOT NULL COMMENT '保育所名',
  `billing_number` int UNSIGNED DEFAULT NULL COMMENT '請求管理用の番号',
  `bnursery_id` int NOT NULL COMMENT '従来の保育園idと連携するためのid',
  `storage_type_id` int UNSIGNED NOT NULL DEFAULT '1' COMMENT '容量id',
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='法人の保有施設一覧';

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
-- テーブルの構造 `files`
--

CREATE TABLE `files` (
  `id` int UNSIGNED NOT NULL,
  `s3_file_name` varchar(255) COLLATE utf8mb4_general_ci NOT NULL COMMENT 's3保存時のファイル名',
  `original_file_name` varchar(255) COLLATE utf8mb4_general_ci NOT NULL COMMENT '送信時のファイル名',
  `file_size` int UNSIGNED NOT NULL COMMENT 'ファイルサイズ',
  `facility_id` int UNSIGNED NOT NULL COMMENT '施設id',
  `employee_id` int UNSIGNED NOT NULL COMMENT '従業員id',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='ファイル';

-- --------------------------------------------------------

--
-- テーブルの構造 `meals`
--

CREATE TABLE `meals` (
  `id` int UNSIGNED NOT NULL,
  `child_id` int UNSIGNED NOT NULL COMMENT '児童id',
  `employee_id` int UNSIGNED NOT NULL COMMENT '従業員id',
  `meal_type` varchar(255) COLLATE utf8mb4_general_ci NOT NULL COMMENT '食事のタイプ',
  `note` varchar(255) COLLATE utf8mb4_general_ci NOT NULL COMMENT 'コメント',
  `eat_on` date NOT NULL COMMENT '食べた日',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- テーブルの構造 `meal_items`
--

CREATE TABLE `meal_items` (
  `id` int UNSIGNED NOT NULL,
  `meal_id` int UNSIGNED NOT NULL,
  `category` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `amount` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
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
-- テーブルの構造 `milks`
--

CREATE TABLE `milks` (
  `id` int UNSIGNED NOT NULL,
  `child_meal_id` int UNSIGNED NOT NULL COMMENT '児童の食事のid',
  `employee_id` int UNSIGNED NOT NULL COMMENT '従業員のid',
  `amount` int UNSIGNED NOT NULL COMMENT '量',
  `time` time NOT NULL COMMENT '時間',
  `contact_to_parents` text COLLATE utf8mb4_general_ci NOT NULL COMMENT '保護者への連絡',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- テーブルの構造 `note_mail_queues`
--

CREATE TABLE `note_mail_queues` (
  `id` int UNSIGNED NOT NULL,
  `mailable_id` int UNSIGNED NOT NULL COMMENT 'お知らせID or メッセージID',
  `mailable_type` varchar(255) COLLATE utf8mb4_general_ci NOT NULL COMMENT 'notice:お知らせ, message:メッセージ',
  `connection_id` int UNSIGNED NOT NULL COMMENT 'connectionsテーブルの主キー（否企業ID）',
  `reserving_time` datetime NOT NULL COMMENT '送信予定日時',
  `batch_in_progress` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'バッチ進行中フラグ',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- テーブルの構造 `payment_number_request_statuses`
--

CREATE TABLE `payment_number_request_statuses` (
  `id` int UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_general_ci NOT NULL COMMENT '申請ステータス名: 申請中 審査中 審査完了 再申請',
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='施設が保有する振替先口座の枝番号申請ステータスマスタ';

-- --------------------------------------------------------

--
-- テーブルの構造 `plans`
--

CREATE TABLE `plans` (
  `id` int UNSIGNED NOT NULL,
  `title` varchar(255) COLLATE utf8mb4_general_ci NOT NULL COMMENT '計画のタイトル',
  `facility_id` int UNSIGNED NOT NULL COMMENT '施設id',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='計画';

-- --------------------------------------------------------

--
-- テーブルの構造 `plan_approvers`
--

CREATE TABLE `plan_approvers` (
  `id` int UNSIGNED NOT NULL,
  `approved_on` date DEFAULT NULL COMMENT '検印を押した日付',
  `plan_id` int UNSIGNED NOT NULL COMMENT '計画id',
  `employee_id` int UNSIGNED DEFAULT NULL COMMENT '従業員id',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- テーブルの構造 `plan_properties`
--

CREATE TABLE `plan_properties` (
  `id` int UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_general_ci NOT NULL COMMENT '項目名',
  `body` text COLLATE utf8mb4_general_ci NOT NULL COMMENT '項目の内容',
  `plan_id` int UNSIGNED NOT NULL COMMENT '計画id',
  `display_order` int NOT NULL COMMENT '表示順',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='計画に紐づく項目一覧';

-- --------------------------------------------------------

--
-- テーブルの構造 `plan_terms`
--

CREATE TABLE `plan_terms` (
  `id` int UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_general_ci NOT NULL COMMENT '期間名',
  `start_at` datetime NOT NULL COMMENT '開始日',
  `end_at` datetime NOT NULL COMMENT '終了日',
  `plan_id` int UNSIGNED NOT NULL COMMENT '計画id',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='計画の期間一覧';

-- --------------------------------------------------------

--
-- テーブルの構造 `plan_term_properties`
--

CREATE TABLE `plan_term_properties` (
  `id` int UNSIGNED NOT NULL,
  `body` text COLLATE utf8mb4_general_ci NOT NULL COMMENT '項目の内容',
  `plan_term_id` int UNSIGNED NOT NULL COMMENT '計画の期間id',
  `plan_term_property_name_id` int UNSIGNED NOT NULL COMMENT '計画の期間に紐づく項目id',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='計画の各期間に紐づく項目の内容一覧';

-- --------------------------------------------------------

--
-- テーブルの構造 `plan_term_property_names`
--

CREATE TABLE `plan_term_property_names` (
  `id` int UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_general_ci NOT NULL COMMENT '項目名',
  `plan_id` int UNSIGNED NOT NULL COMMENT '計画id',
  `display_order` int NOT NULL COMMENT '表示順',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='計画の期間に紐づく項目名一覧';

-- --------------------------------------------------------

--
-- テーブルの構造 `questionnaires`
--

CREATE TABLE `questionnaires` (
  `id` int UNSIGNED NOT NULL,
  `corporation_id` int UNSIGNED NOT NULL COMMENT '法人ID',
  `facility_id` int UNSIGNED DEFAULT NULL,
  `close_at` datetime DEFAULT NULL COMMENT '回答締切日時',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- テーブルの構造 `questions`
--

CREATE TABLE `questions` (
  `id` int UNSIGNED NOT NULL,
  `questionnaire_id` int UNSIGNED NOT NULL COMMENT 'アンケートID',
  `text` text COLLATE utf8mb4_general_ci NOT NULL COMMENT '質問文',
  `is_required` tinyint(1) NOT NULL DEFAULT '0' COMMENT '必須かどうか',
  `answer_type` varchar(255) COLLATE utf8mb4_general_ci NOT NULL COMMENT '回答方法',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- テーブルの構造 `storage_types`
--

CREATE TABLE `storage_types` (
  `id` int UNSIGNED NOT NULL,
  `capacity` int NOT NULL COMMENT '容量(GB)',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='容量種類';

--
-- ダンプしたテーブルのインデックス
--

--
-- テーブルのインデックス `activities`
--
ALTER TABLE `activities`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `activities_image_uuid_unique` (`image_uuid`),
  ADD KEY `activities_facility_id_foreign` (`facility_id`);

--
-- テーブルのインデックス `activity_childcare_activity`
--
ALTER TABLE `activity_childcare_activity`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `activity_unique` (`activity_id`,`childcare_activity_id`),
  ADD KEY `activity_childcare_activity_childcare_activity_id_foreign` (`childcare_activity_id`);

--
-- テーブルのインデックス `answers`
--
ALTER TABLE `answers`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `answers_question_id_respondent_id_unique` (`question_id`,`respondent_id`),
  ADD KEY `answers_respondent_id_foreign` (`respondent_id`);

--
-- テーブルのインデックス `archives`
--
ALTER TABLE `archives`
  ADD PRIMARY KEY (`id`),
  ADD KEY `archives_facility_id_foreign` (`facility_id`);

--
-- テーブルのインデックス `archive_file`
--
ALTER TABLE `archive_file`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `archive_file_unique` (`archive_id`,`file_id`),
  ADD KEY `archive_file_file_id_foreign` (`file_id`);

--
-- テーブルのインデックス `archive_permissions`
--
ALTER TABLE `archive_permissions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `archive_permissions_archive_id_foreign` (`archive_id`),
  ADD KEY `archive_permissions_archive_permission_level_id_foreign` (`archive_permission_level_id`),
  ADD KEY `archive_permissions_employee_id_foreign` (`employee_id`);

--
-- テーブルのインデックス `archive_permission_levels`
--
ALTER TABLE `archive_permission_levels`
  ADD PRIMARY KEY (`id`);

--
-- テーブルのインデックス `bank_account_types`
--
ALTER TABLE `bank_account_types`
  ADD PRIMARY KEY (`id`);

--
-- テーブルのインデックス `bookings`
--
ALTER TABLE `bookings`
  ADD PRIMARY KEY (`reservation_requiry_number`),
  ADD KEY `bookings_index` (`facility_number`,`reservation_requiry_status`,`status_update_datetime`);

--
-- テーブルのインデックス `booking_responses`
--
ALTER TABLE `booking_responses`
  ADD PRIMARY KEY (`id`);

--
-- テーブルのインデックス `childcare_activities`
--
ALTER TABLE `childcare_activities`
  ADD PRIMARY KEY (`id`),
  ADD KEY `childcare_activities_facility_id_foreign` (`facility_id`);

--
-- テーブルのインデックス `children`
--
ALTER TABLE `children`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `children_facility_id_bchild_id_admission_on_unique` (`facility_id`,`bchild_id`,`admission_on`);

--
-- テーブルのインデックス `child_classroom`
--
ALTER TABLE `child_classroom`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `child_classroom_child_id_classroom_id_start_on_unique` (`child_id`,`classroom_id`,`start_on`),
  ADD KEY `child_classroom_classroom_id_foreign` (`classroom_id`);

--
-- テーブルのインデックス `child_direct_debit_request`
--
ALTER TABLE `child_direct_debit_request`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `child_direct_debit_request_child_id_unique` (`child_id`),
  ADD KEY `child_direct_debit_request_direct_debit_request_id_foreign` (`direct_debit_request_id`);

--
-- テーブルのインデックス `child_meals`
--
ALTER TABLE `child_meals`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `child_meals_class_meal_id_child_id_unique` (`class_meal_id`,`child_id`),
  ADD KEY `child_meals_child_id_foreign` (`child_id`);

--
-- テーブルのインデックス `choices`
--
ALTER TABLE `choices`
  ADD PRIMARY KEY (`id`),
  ADD KEY `choices_question_id_foreign` (`question_id`);

--
-- テーブルのインデックス `classrooms`
--
ALTER TABLE `classrooms`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `classrooms_facility_id_bclass_id_unique` (`facility_id`,`bclass_id`);

--
-- テーブルのインデックス `classroom_meal_remarks`
--
ALTER TABLE `classroom_meal_remarks`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `classroom_meal_remarks_classroom_id_eat_on_meal_type_unique` (`classroom_id`,`eat_on`,`meal_type`);

--
-- テーブルのインデックス `class_meals`
--
ALTER TABLE `class_meals`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `class_meals_classroom_id_date_unique` (`classroom_id`,`date`);

--
-- テーブルのインデックス `corporations`
--
ALTER TABLE `corporations`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `corporations_code_unique` (`code`);

--
-- テーブルのインデックス `direct_debits`
--
ALTER TABLE `direct_debits`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `direct_debits_contract_number_payment_number_unique` (`contract_number`,`payment_number`),
  ADD UNIQUE KEY `direct_debits_facility_id_unique` (`facility_id`),
  ADD KEY `direct_debits_contract_number_payment_number_index` (`contract_number`,`payment_number`),
  ADD KEY `direct_debits_account_type_id_foreign` (`account_type_id`),
  ADD KEY `direct_debits_payment_number_request_status_id_foreign` (`payment_number_request_status_id`);

--
-- テーブルのインデックス `direct_debit_requests`
--
ALTER TABLE `direct_debit_requests`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `account_unique` (`direct_debit_id`,`bank_code`,`branch_code`,`account_code`,`account_type_id`),
  ADD KEY `direct_debit_requests_account_type_id_foreign` (`account_type_id`);

--
-- テーブルのインデックス `direct_debit_transactions`
--
ALTER TABLE `direct_debit_transactions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `account_unique` (`billing_on`,`direct_debit_request_id`,`child_id`),
  ADD KEY `direct_debit_transactions_child_id_foreign` (`child_id`),
  ADD KEY `direct_debit_transactions_direct_debit_request_id_foreign` (`direct_debit_request_id`),
  ADD KEY `transferer_information` (`account_type_id`,`bank_code`,`branch_code`,`account_code`);

--
-- テーブルのインデックス `direct_debit_transaction_return_codes`
--
ALTER TABLE `direct_debit_transaction_return_codes`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `direct_debit_transaction_return_codes_code_unique` (`code`);

--
-- テーブルのインデックス `employees`
--
ALTER TABLE `employees`
  ADD PRIMARY KEY (`id`),
  ADD KEY `employees_corporation_id_foreign` (`corporation_id`);

--
-- テーブルのインデックス `employee_facility`
--
ALTER TABLE `employee_facility`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `employee_facility_start_on_unique` (`employee_id`,`facility_id`,`start_on`),
  ADD KEY `employee_facility_facility_id_foreign` (`facility_id`);

--
-- テーブルのインデックス `facilities`
--
ALTER TABLE `facilities`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `facilities_corporation_id_bnursery_id_unique` (`corporation_id`,`bnursery_id`),
  ADD KEY `facilities_storage_type_id_foreign` (`storage_type_id`);

--
-- テーブルのインデックス `failed_jobs`
--
ALTER TABLE `failed_jobs`
  ADD PRIMARY KEY (`id`);

--
-- テーブルのインデックス `files`
--
ALTER TABLE `files`
  ADD PRIMARY KEY (`id`),
  ADD KEY `files_facility_id_foreign` (`facility_id`),
  ADD KEY `files_employee_id_foreign` (`employee_id`);

--
-- テーブルのインデックス `meals`
--
ALTER TABLE `meals`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `meals_child_id_meal_type_eat_on_unique` (`child_id`,`meal_type`,`eat_on`),
  ADD KEY `meals_employee_id_foreign` (`employee_id`);

--
-- テーブルのインデックス `meal_items`
--
ALTER TABLE `meal_items`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `meal_items_meal_id_category_unique` (`meal_id`,`category`);

--
-- テーブルのインデックス `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- テーブルのインデックス `milks`
--
ALTER TABLE `milks`
  ADD PRIMARY KEY (`id`),
  ADD KEY `milks_child_meal_id_foreign` (`child_meal_id`),
  ADD KEY `milks_employee_id_foreign` (`employee_id`);

--
-- テーブルのインデックス `note_mail_queues`
--
ALTER TABLE `note_mail_queues`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `note_mail_queues_mailable_id_mailable_type_connection_id_unique` (`mailable_id`,`mailable_type`,`connection_id`),
  ADD KEY `note_mail_queues_connection_id_foreign` (`connection_id`),
  ADD KEY `note_mail_queues_reserving_time_index` (`reserving_time`);

--
-- テーブルのインデックス `payment_number_request_statuses`
--
ALTER TABLE `payment_number_request_statuses`
  ADD PRIMARY KEY (`id`);

--
-- テーブルのインデックス `plans`
--
ALTER TABLE `plans`
  ADD PRIMARY KEY (`id`),
  ADD KEY `plans_facility_id_foreign` (`facility_id`);

--
-- テーブルのインデックス `plan_approvers`
--
ALTER TABLE `plan_approvers`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `approver_unique` (`plan_id`,`employee_id`),
  ADD KEY `plan_approvers_employee_id_foreign` (`employee_id`);

--
-- テーブルのインデックス `plan_properties`
--
ALTER TABLE `plan_properties`
  ADD PRIMARY KEY (`id`),
  ADD KEY `plan_properties_plan_id_foreign` (`plan_id`);

--
-- テーブルのインデックス `plan_terms`
--
ALTER TABLE `plan_terms`
  ADD PRIMARY KEY (`id`),
  ADD KEY `plan_terms_plan_id_foreign` (`plan_id`);

--
-- テーブルのインデックス `plan_term_properties`
--
ALTER TABLE `plan_term_properties`
  ADD PRIMARY KEY (`id`),
  ADD KEY `plan_term_properties_plan_term_id_foreign` (`plan_term_id`),
  ADD KEY `plan_term_properties_plan_term_property_name_id_foreign` (`plan_term_property_name_id`);

--
-- テーブルのインデックス `plan_term_property_names`
--
ALTER TABLE `plan_term_property_names`
  ADD PRIMARY KEY (`id`),
  ADD KEY `plan_term_property_names_plan_id_foreign` (`plan_id`);

--
-- テーブルのインデックス `questionnaires`
--
ALTER TABLE `questionnaires`
  ADD PRIMARY KEY (`id`),
  ADD KEY `questionnaires_corporation_id_foreign` (`corporation_id`),
  ADD KEY `questionnaires_facility_id_foreign` (`facility_id`);

--
-- テーブルのインデックス `questions`
--
ALTER TABLE `questions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `questions_questionnaire_id_foreign` (`questionnaire_id`);

--
-- テーブルのインデックス `storage_types`
--
ALTER TABLE `storage_types`
  ADD PRIMARY KEY (`id`);

--
-- ダンプしたテーブルの AUTO_INCREMENT
--

--
-- テーブルの AUTO_INCREMENT `activities`
--
ALTER TABLE `activities`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- テーブルの AUTO_INCREMENT `activity_childcare_activity`
--
ALTER TABLE `activity_childcare_activity`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- テーブルの AUTO_INCREMENT `answers`
--
ALTER TABLE `answers`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- テーブルの AUTO_INCREMENT `archives`
--
ALTER TABLE `archives`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- テーブルの AUTO_INCREMENT `archive_file`
--
ALTER TABLE `archive_file`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- テーブルの AUTO_INCREMENT `archive_permissions`
--
ALTER TABLE `archive_permissions`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- テーブルの AUTO_INCREMENT `archive_permission_levels`
--
ALTER TABLE `archive_permission_levels`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- テーブルの AUTO_INCREMENT `bank_account_types`
--
ALTER TABLE `bank_account_types`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- テーブルの AUTO_INCREMENT `booking_responses`
--
ALTER TABLE `booking_responses`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- テーブルの AUTO_INCREMENT `childcare_activities`
--
ALTER TABLE `childcare_activities`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- テーブルの AUTO_INCREMENT `children`
--
ALTER TABLE `children`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- テーブルの AUTO_INCREMENT `child_classroom`
--
ALTER TABLE `child_classroom`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- テーブルの AUTO_INCREMENT `child_direct_debit_request`
--
ALTER TABLE `child_direct_debit_request`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- テーブルの AUTO_INCREMENT `child_meals`
--
ALTER TABLE `child_meals`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- テーブルの AUTO_INCREMENT `choices`
--
ALTER TABLE `choices`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- テーブルの AUTO_INCREMENT `classrooms`
--
ALTER TABLE `classrooms`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- テーブルの AUTO_INCREMENT `classroom_meal_remarks`
--
ALTER TABLE `classroom_meal_remarks`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- テーブルの AUTO_INCREMENT `class_meals`
--
ALTER TABLE `class_meals`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- テーブルの AUTO_INCREMENT `corporations`
--
ALTER TABLE `corporations`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- テーブルの AUTO_INCREMENT `direct_debits`
--
ALTER TABLE `direct_debits`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- テーブルの AUTO_INCREMENT `direct_debit_requests`
--
ALTER TABLE `direct_debit_requests`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- テーブルの AUTO_INCREMENT `direct_debit_transactions`
--
ALTER TABLE `direct_debit_transactions`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- テーブルの AUTO_INCREMENT `direct_debit_transaction_return_codes`
--
ALTER TABLE `direct_debit_transaction_return_codes`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- テーブルの AUTO_INCREMENT `employees`
--
ALTER TABLE `employees`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- テーブルの AUTO_INCREMENT `employee_facility`
--
ALTER TABLE `employee_facility`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- テーブルの AUTO_INCREMENT `facilities`
--
ALTER TABLE `facilities`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- テーブルの AUTO_INCREMENT `failed_jobs`
--
ALTER TABLE `failed_jobs`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- テーブルの AUTO_INCREMENT `files`
--
ALTER TABLE `files`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- テーブルの AUTO_INCREMENT `meals`
--
ALTER TABLE `meals`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- テーブルの AUTO_INCREMENT `meal_items`
--
ALTER TABLE `meal_items`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- テーブルの AUTO_INCREMENT `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- テーブルの AUTO_INCREMENT `milks`
--
ALTER TABLE `milks`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- テーブルの AUTO_INCREMENT `note_mail_queues`
--
ALTER TABLE `note_mail_queues`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- テーブルの AUTO_INCREMENT `payment_number_request_statuses`
--
ALTER TABLE `payment_number_request_statuses`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- テーブルの AUTO_INCREMENT `plans`
--
ALTER TABLE `plans`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- テーブルの AUTO_INCREMENT `plan_approvers`
--
ALTER TABLE `plan_approvers`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- テーブルの AUTO_INCREMENT `plan_properties`
--
ALTER TABLE `plan_properties`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- テーブルの AUTO_INCREMENT `plan_terms`
--
ALTER TABLE `plan_terms`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- テーブルの AUTO_INCREMENT `plan_term_properties`
--
ALTER TABLE `plan_term_properties`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- テーブルの AUTO_INCREMENT `plan_term_property_names`
--
ALTER TABLE `plan_term_property_names`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- テーブルの AUTO_INCREMENT `questionnaires`
--
ALTER TABLE `questionnaires`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- テーブルの AUTO_INCREMENT `questions`
--
ALTER TABLE `questions`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- テーブルの AUTO_INCREMENT `storage_types`
--
ALTER TABLE `storage_types`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT;

-- --------------------------------------------------------

--
-- ビュー用の構造 `connections`
--
DROP TABLE IF EXISTS `connections`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `connections`  AS SELECT `corporations`.`id` AS `id`, `corporations`.`code` AS `dbname` FROM `corporations` ;

--
-- ダンプしたテーブルの制約
--

--
-- テーブルの制約 `activities`
--
ALTER TABLE `activities`
  ADD CONSTRAINT `activities_facility_id_foreign` FOREIGN KEY (`facility_id`) REFERENCES `facilities` (`id`);

--
-- テーブルの制約 `activity_childcare_activity`
--
ALTER TABLE `activity_childcare_activity`
  ADD CONSTRAINT `activity_childcare_activity_activity_id_foreign` FOREIGN KEY (`activity_id`) REFERENCES `activities` (`id`),
  ADD CONSTRAINT `activity_childcare_activity_childcare_activity_id_foreign` FOREIGN KEY (`childcare_activity_id`) REFERENCES `childcare_activities` (`id`);

--
-- テーブルの制約 `answers`
--
ALTER TABLE `answers`
  ADD CONSTRAINT `answers_question_id_foreign` FOREIGN KEY (`question_id`) REFERENCES `questions` (`id`),
  ADD CONSTRAINT `answers_respondent_id_foreign` FOREIGN KEY (`respondent_id`) REFERENCES `children` (`id`);

--
-- テーブルの制約 `archives`
--
ALTER TABLE `archives`
  ADD CONSTRAINT `archives_facility_id_foreign` FOREIGN KEY (`facility_id`) REFERENCES `facilities` (`id`);

--
-- テーブルの制約 `archive_file`
--
ALTER TABLE `archive_file`
  ADD CONSTRAINT `archive_file_archive_id_foreign` FOREIGN KEY (`archive_id`) REFERENCES `archives` (`id`),
  ADD CONSTRAINT `archive_file_file_id_foreign` FOREIGN KEY (`file_id`) REFERENCES `files` (`id`);

--
-- テーブルの制約 `archive_permissions`
--
ALTER TABLE `archive_permissions`
  ADD CONSTRAINT `archive_permissions_archive_id_foreign` FOREIGN KEY (`archive_id`) REFERENCES `archives` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `archive_permissions_archive_permission_level_id_foreign` FOREIGN KEY (`archive_permission_level_id`) REFERENCES `archive_permission_levels` (`id`),
  ADD CONSTRAINT `archive_permissions_employee_id_foreign` FOREIGN KEY (`employee_id`) REFERENCES `employees` (`id`);

--
-- テーブルの制約 `childcare_activities`
--
ALTER TABLE `childcare_activities`
  ADD CONSTRAINT `childcare_activities_facility_id_foreign` FOREIGN KEY (`facility_id`) REFERENCES `facilities` (`id`);

--
-- テーブルの制約 `children`
--
ALTER TABLE `children`
  ADD CONSTRAINT `children_facility_id_foreign` FOREIGN KEY (`facility_id`) REFERENCES `facilities` (`id`);

--
-- テーブルの制約 `child_classroom`
--
ALTER TABLE `child_classroom`
  ADD CONSTRAINT `child_classroom_child_id_foreign` FOREIGN KEY (`child_id`) REFERENCES `children` (`id`),
  ADD CONSTRAINT `child_classroom_classroom_id_foreign` FOREIGN KEY (`classroom_id`) REFERENCES `classrooms` (`id`);

--
-- テーブルの制約 `child_direct_debit_request`
--
ALTER TABLE `child_direct_debit_request`
  ADD CONSTRAINT `child_direct_debit_request_child_id_foreign` FOREIGN KEY (`child_id`) REFERENCES `children` (`id`),
  ADD CONSTRAINT `child_direct_debit_request_direct_debit_request_id_foreign` FOREIGN KEY (`direct_debit_request_id`) REFERENCES `direct_debit_requests` (`id`);

--
-- テーブルの制約 `child_meals`
--
ALTER TABLE `child_meals`
  ADD CONSTRAINT `child_meals_child_id_foreign` FOREIGN KEY (`child_id`) REFERENCES `children` (`id`),
  ADD CONSTRAINT `child_meals_class_meal_id_foreign` FOREIGN KEY (`class_meal_id`) REFERENCES `class_meals` (`id`);

--
-- テーブルの制約 `choices`
--
ALTER TABLE `choices`
  ADD CONSTRAINT `choices_question_id_foreign` FOREIGN KEY (`question_id`) REFERENCES `questions` (`id`);

--
-- テーブルの制約 `classrooms`
--
ALTER TABLE `classrooms`
  ADD CONSTRAINT `classrooms_facility_id_foreign` FOREIGN KEY (`facility_id`) REFERENCES `facilities` (`id`);

--
-- テーブルの制約 `classroom_meal_remarks`
--
ALTER TABLE `classroom_meal_remarks`
  ADD CONSTRAINT `classroom_meal_remarks_classroom_id_foreign` FOREIGN KEY (`classroom_id`) REFERENCES `classrooms` (`id`);

--
-- テーブルの制約 `class_meals`
--
ALTER TABLE `class_meals`
  ADD CONSTRAINT `class_meals_classroom_id_foreign` FOREIGN KEY (`classroom_id`) REFERENCES `classrooms` (`id`);

--
-- テーブルの制約 `direct_debits`
--
ALTER TABLE `direct_debits`
  ADD CONSTRAINT `direct_debits_account_type_id_foreign` FOREIGN KEY (`account_type_id`) REFERENCES `bank_account_types` (`id`),
  ADD CONSTRAINT `direct_debits_facility_id_foreign` FOREIGN KEY (`facility_id`) REFERENCES `facilities` (`id`),
  ADD CONSTRAINT `direct_debits_payment_number_request_status_id_foreign` FOREIGN KEY (`payment_number_request_status_id`) REFERENCES `payment_number_request_statuses` (`id`);

--
-- テーブルの制約 `direct_debit_requests`
--
ALTER TABLE `direct_debit_requests`
  ADD CONSTRAINT `direct_debit_requests_account_type_id_foreign` FOREIGN KEY (`account_type_id`) REFERENCES `bank_account_types` (`id`),
  ADD CONSTRAINT `direct_debit_requests_direct_debit_id_foreign` FOREIGN KEY (`direct_debit_id`) REFERENCES `direct_debits` (`id`);

--
-- テーブルの制約 `direct_debit_transactions`
--
ALTER TABLE `direct_debit_transactions`
  ADD CONSTRAINT `direct_debit_transactions_child_id_foreign` FOREIGN KEY (`child_id`) REFERENCES `children` (`id`),
  ADD CONSTRAINT `direct_debit_transactions_direct_debit_request_id_foreign` FOREIGN KEY (`direct_debit_request_id`) REFERENCES `direct_debit_requests` (`id`);

--
-- テーブルの制約 `employees`
--
ALTER TABLE `employees`
  ADD CONSTRAINT `employees_corporation_id_foreign` FOREIGN KEY (`corporation_id`) REFERENCES `corporations` (`id`);

--
-- テーブルの制約 `employee_facility`
--
ALTER TABLE `employee_facility`
  ADD CONSTRAINT `employee_facility_employee_id_foreign` FOREIGN KEY (`employee_id`) REFERENCES `employees` (`id`),
  ADD CONSTRAINT `employee_facility_facility_id_foreign` FOREIGN KEY (`facility_id`) REFERENCES `facilities` (`id`);

--
-- テーブルの制約 `facilities`
--
ALTER TABLE `facilities`
  ADD CONSTRAINT `facilities_corporation_id_foreign` FOREIGN KEY (`corporation_id`) REFERENCES `corporations` (`id`),
  ADD CONSTRAINT `facilities_storage_type_id_foreign` FOREIGN KEY (`storage_type_id`) REFERENCES `storage_types` (`id`);

--
-- テーブルの制約 `files`
--
ALTER TABLE `files`
  ADD CONSTRAINT `files_employee_id_foreign` FOREIGN KEY (`employee_id`) REFERENCES `employees` (`id`),
  ADD CONSTRAINT `files_facility_id_foreign` FOREIGN KEY (`facility_id`) REFERENCES `facilities` (`id`);

--
-- テーブルの制約 `meals`
--
ALTER TABLE `meals`
  ADD CONSTRAINT `meals_child_id_foreign` FOREIGN KEY (`child_id`) REFERENCES `children` (`id`),
  ADD CONSTRAINT `meals_employee_id_foreign` FOREIGN KEY (`employee_id`) REFERENCES `employees` (`id`);

--
-- テーブルの制約 `meal_items`
--
ALTER TABLE `meal_items`
  ADD CONSTRAINT `meal_items_meal_id_foreign` FOREIGN KEY (`meal_id`) REFERENCES `meals` (`id`);

--
-- テーブルの制約 `milks`
--
ALTER TABLE `milks`
  ADD CONSTRAINT `milks_child_meal_id_foreign` FOREIGN KEY (`child_meal_id`) REFERENCES `child_meals` (`id`),
  ADD CONSTRAINT `milks_employee_id_foreign` FOREIGN KEY (`employee_id`) REFERENCES `employees` (`id`);

--
-- テーブルの制約 `note_mail_queues`
--
ALTER TABLE `note_mail_queues`
  ADD CONSTRAINT `note_mail_queues_connection_id_foreign` FOREIGN KEY (`connection_id`) REFERENCES `corporations` (`id`);

--
-- テーブルの制約 `plans`
--
ALTER TABLE `plans`
  ADD CONSTRAINT `plans_facility_id_foreign` FOREIGN KEY (`facility_id`) REFERENCES `facilities` (`id`);

--
-- テーブルの制約 `plan_approvers`
--
ALTER TABLE `plan_approvers`
  ADD CONSTRAINT `plan_approvers_employee_id_foreign` FOREIGN KEY (`employee_id`) REFERENCES `employees` (`id`),
  ADD CONSTRAINT `plan_approvers_plan_id_foreign` FOREIGN KEY (`plan_id`) REFERENCES `plans` (`id`) ON DELETE CASCADE;

--
-- テーブルの制約 `plan_properties`
--
ALTER TABLE `plan_properties`
  ADD CONSTRAINT `plan_properties_plan_id_foreign` FOREIGN KEY (`plan_id`) REFERENCES `plans` (`id`);

--
-- テーブルの制約 `plan_terms`
--
ALTER TABLE `plan_terms`
  ADD CONSTRAINT `plan_terms_plan_id_foreign` FOREIGN KEY (`plan_id`) REFERENCES `plans` (`id`);

--
-- テーブルの制約 `plan_term_properties`
--
ALTER TABLE `plan_term_properties`
  ADD CONSTRAINT `plan_term_properties_plan_term_id_foreign` FOREIGN KEY (`plan_term_id`) REFERENCES `plan_terms` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `plan_term_properties_plan_term_property_name_id_foreign` FOREIGN KEY (`plan_term_property_name_id`) REFERENCES `plan_term_property_names` (`id`) ON DELETE CASCADE;

--
-- テーブルの制約 `plan_term_property_names`
--
ALTER TABLE `plan_term_property_names`
  ADD CONSTRAINT `plan_term_property_names_plan_id_foreign` FOREIGN KEY (`plan_id`) REFERENCES `plans` (`id`);

--
-- テーブルの制約 `questionnaires`
--
ALTER TABLE `questionnaires`
  ADD CONSTRAINT `questionnaires_corporation_id_foreign` FOREIGN KEY (`corporation_id`) REFERENCES `corporations` (`id`),
  ADD CONSTRAINT `questionnaires_facility_id_foreign` FOREIGN KEY (`facility_id`) REFERENCES `facilities` (`id`);

--
-- テーブルの制約 `questions`
--
ALTER TABLE `questions`
  ADD CONSTRAINT `questions_questionnaire_id_foreign` FOREIGN KEY (`questionnaire_id`) REFERENCES `questionnaires` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
