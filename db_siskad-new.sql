/*
 Navicat Premium Data Transfer

 Source Server         : deact-local
 Source Server Type    : MySQL
 Source Server Version : 100427
 Source Host           : localhost:3306
 Source Schema         : db_siskad

 Target Server Type    : MySQL
 Target Server Version : 100427
 File Encoding         : 65001

 Date: 16/07/2023 20:57:03
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for daftar_nilais
-- ----------------------------
DROP TABLE IF EXISTS `daftar_nilais`;
CREATE TABLE `daftar_nilais`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `judul_kategori` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `kategori_tugas` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `id_tahun_ajaran` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `id_kelas` int NULL DEFAULT NULL,
  `id_mata_kuliah` int NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 47 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of daftar_nilais
-- ----------------------------

-- ----------------------------
-- Table structure for jadwals
-- ----------------------------
DROP TABLE IF EXISTS `jadwals`;
CREATE TABLE `jadwals`  (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `id_mata_kuliah_enroll` int NULL DEFAULT NULL,
  `hari` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `jam_mulai` time NULL DEFAULT NULL,
  `jam_selesai` time NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 16 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of jadwals
-- ----------------------------

-- ----------------------------
-- Table structure for jurusans
-- ----------------------------
DROP TABLE IF EXISTS `jurusans`;
CREATE TABLE `jurusans`  (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `nama_jurusan` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 7 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of jurusans
-- ----------------------------
INSERT INTO `jurusans` VALUES (1, '2023-07-09 04:28:06', '2023-07-09 04:28:06', 'Manajemen Informatika');
INSERT INTO `jurusans` VALUES (4, '2023-07-09 04:28:18', '2023-07-09 04:28:18', 'Agroindustri');
INSERT INTO `jurusans` VALUES (5, '2023-07-09 04:28:47', '2023-07-09 04:28:47', 'Kesehatan');
INSERT INTO `jurusans` VALUES (6, '2023-07-09 04:28:52', '2023-07-09 04:28:52', 'Teknik Perawatan dan Perbaikan Mesin');

-- ----------------------------
-- Table structure for kehadirans
-- ----------------------------
DROP TABLE IF EXISTS `kehadirans`;
CREATE TABLE `kehadirans`  (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `id_jadwal` int NULL DEFAULT NULL,
  `id_mahasiswa` int NULL DEFAULT NULL,
  `deskripsi` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `pertemuan` int NOT NULL,
  `tanggal` date NULL DEFAULT NULL,
  `jam_masuk_mahasiswa` time NOT NULL DEFAULT '00:00:00',
  `terlambat` int NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 47 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of kehadirans
-- ----------------------------
INSERT INTO `kehadirans` VALUES (42, '2023-07-16 17:12:48', '2023-07-16 17:13:35', 15, 11, 'dasar dasar ...', 'hadir', 1, '2023-07-16', '00:00:00', 20);
INSERT INTO `kehadirans` VALUES (43, '2023-07-16 17:12:48', '2023-07-16 17:13:35', 15, 12, 'dasar dasar ...', 'hadir', 1, '2023-07-16', '00:00:00', 15);
INSERT INTO `kehadirans` VALUES (44, '2023-07-16 17:12:48', '2023-07-16 17:13:35', 15, 13, 'dasar dasar ...', 'tanpa keterangan', 1, '2023-07-16', '00:00:00', 3);
INSERT INTO `kehadirans` VALUES (45, '2023-07-16 17:12:48', '2023-07-16 17:13:35', 15, 14, 'dasar dasar ...', 'hadir', 1, '2023-07-16', '00:00:00', 2);
INSERT INTO `kehadirans` VALUES (46, '2023-07-16 17:12:48', '2023-07-16 17:13:35', 15, 15, 'dasar dasar ...', 'hadir', 1, '2023-07-16', '00:00:00', 0);

-- ----------------------------
-- Table structure for kelas
-- ----------------------------
DROP TABLE IF EXISTS `kelas`;
CREATE TABLE `kelas`  (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `id_tahun_ajaran` int NULL DEFAULT NULL,
  `angkatan` int NOT NULL,
  `nama_kelas` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `status` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `kode_kelas` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `id_dosen_wali` int NULL DEFAULT NULL,
  `id_prodi` int NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 16 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of kelas
-- ----------------------------
INSERT INTO `kelas` VALUES (3, '2023-07-09 05:58:06', '2023-07-16 16:29:32', 1, 2020, 'Sistem Informasi 1A', 'aktif', 'SI1A01', 21, 1);
INSERT INTO `kelas` VALUES (4, '2023-07-09 05:58:25', '2023-07-16 16:27:24', 1, 2020, 'Sistem Informasi 1B', 'aktif', 'SI1B01', 21, 1);
INSERT INTO `kelas` VALUES (5, '2023-07-09 05:58:52', '2023-07-16 16:27:32', 2, 2020, 'Sistem Informasi 1A', 'aktif', 'SI1A02', 21, 1);
INSERT INTO `kelas` VALUES (6, '2023-07-09 05:59:11', '2023-07-16 16:27:39', 2, 2020, 'Sistem Informasi 1B', 'aktif', 'SI1B02', 21, 1);
INSERT INTO `kelas` VALUES (7, '2023-07-09 06:02:17', '2023-07-16 16:27:46', 3, 2020, 'Sistem Informasi 2A', 'aktif', 'SI2A01', 21, 1);
INSERT INTO `kelas` VALUES (8, '2023-07-09 06:02:32', '2023-07-16 16:27:55', 3, 2020, 'Sistem Informasi 2B', 'aktif', 'SI2B01', 21, 1);
INSERT INTO `kelas` VALUES (9, '2023-07-09 06:02:49', '2023-07-16 16:28:03', 4, 2020, 'Sistem Informasi 2A', 'aktif', 'SI2A02', 21, 1);
INSERT INTO `kelas` VALUES (10, '2023-07-09 06:03:03', '2023-07-16 16:28:09', 4, 2020, 'Sistem Informasi 2B', 'aktif', 'SI2B02', 21, 1);
INSERT INTO `kelas` VALUES (11, '2023-07-09 06:03:26', '2023-07-16 16:28:15', 5, 2020, 'Sistem Informasi 3A', 'aktif', 'SI3A01', 21, 1);
INSERT INTO `kelas` VALUES (12, '2023-07-09 06:03:40', '2023-07-16 16:28:22', 5, 2020, 'Sistem Informasi 3B', 'aktif', 'SI3B01', 21, 1);
INSERT INTO `kelas` VALUES (13, '2023-07-09 06:04:20', '2023-07-16 16:28:27', 6, 2020, 'Sistem Informasi 3A', 'aktif', 'SI3A02', 21, 1);
INSERT INTO `kelas` VALUES (14, '2023-07-09 06:04:33', '2023-07-16 16:28:35', 6, 2020, 'Sistem Informasi 3B', 'aktif', 'SI3B02', 21, 1);
INSERT INTO `kelas` VALUES (15, '2023-07-10 23:01:28', '2023-07-13 11:20:57', 11, 0, 'Sistem Informatika', 'aktif', 'SI12023', 21, 1);

-- ----------------------------
-- Table structure for kelas_enrolls
-- ----------------------------
DROP TABLE IF EXISTS `kelas_enrolls`;
CREATE TABLE `kelas_enrolls`  (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `id_mahasiswa` int NULL DEFAULT NULL,
  `id_kelas` int NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 77 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of kelas_enrolls
-- ----------------------------

-- ----------------------------
-- Table structure for mahasiswa_mata_kuliah_enrolls
-- ----------------------------
DROP TABLE IF EXISTS `mahasiswa_mata_kuliah_enrolls`;
CREATE TABLE `mahasiswa_mata_kuliah_enrolls`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `id_mata_kuliah_enroll` bigint UNSIGNED NOT NULL,
  `id_mahasiswa` bigint UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 122 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of mahasiswa_mata_kuliah_enrolls
-- ----------------------------

-- ----------------------------
-- Table structure for mata_kuliah_enrolls
-- ----------------------------
DROP TABLE IF EXISTS `mata_kuliah_enrolls`;
CREATE TABLE `mata_kuliah_enrolls`  (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `id_kelas` int NULL DEFAULT NULL,
  `id_mata_kuliah` int NULL DEFAULT NULL,
  `id_dosen` int NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 57 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of mata_kuliah_enrolls
-- ----------------------------

-- ----------------------------
-- Table structure for mata_kuliahs
-- ----------------------------
DROP TABLE IF EXISTS `mata_kuliahs`;
CREATE TABLE `mata_kuliahs`  (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `nama_mata_kuliah` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `id_prodi` int NULL DEFAULT NULL,
  `kode_mata_kuliah` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `sks` int NULL DEFAULT NULL,
  `semester` int NOT NULL DEFAULT 0,
  `status` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 23 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of mata_kuliahs
-- ----------------------------
INSERT INTO `mata_kuliahs` VALUES (5, '2023-07-09 06:22:03', '2023-07-16 16:29:52', 'PENDIDIKAN AGAMA', 1, 'PMU0001', 3, 1, 'aktif');
INSERT INTO `mata_kuliahs` VALUES (6, '2023-07-09 06:22:31', '2023-07-16 16:29:57', 'PEMROGRAMAN DASAR 1', 1, 'PSI3104', 4, 1, 'aktif');
INSERT INTO `mata_kuliahs` VALUES (7, '2023-07-09 06:22:59', '2023-07-16 16:30:02', 'PENGANTAR TEKNOLOGI INFORMASI DAN KOMUNIKASI', 1, 'PSI3102', 4, 1, 'aktif');
INSERT INTO `mata_kuliahs` VALUES (8, '2023-07-09 06:23:19', '2023-07-16 16:30:07', 'PENGANTAR AKUNTANSI', 1, 'PSI3206', 2, 2, 'aktif');
INSERT INTO `mata_kuliahs` VALUES (9, '2023-07-09 06:23:41', '2023-07-16 16:30:11', 'PEMROGRAMAN DASAR 2', 1, 'PSI3204', 4, 2, 'aktif');
INSERT INTO `mata_kuliahs` VALUES (10, '2023-07-09 06:24:09', '2023-07-16 16:30:16', 'PROJEK 1', 1, 'PMI0004', 2, 2, 'aktif');
INSERT INTO `mata_kuliahs` VALUES (11, '2023-07-09 06:24:48', '2023-07-16 16:30:20', 'PEMROGRAMAN BERBASIS OBJEK', 1, 'PSI3301', 3, 3, 'aktif');
INSERT INTO `mata_kuliahs` VALUES (12, '2023-07-09 06:25:06', '2023-07-16 16:30:25', 'BAHASA INGGRIS TEKNIS 1', 1, 'PMI0001', 3, 3, 'aktif');
INSERT INTO `mata_kuliahs` VALUES (13, '2023-07-09 06:25:32', '2023-07-16 16:30:29', 'BASIS DATA 1', 1, 'PSI3302', 4, 3, 'aktif');
INSERT INTO `mata_kuliahs` VALUES (14, '2023-07-09 06:26:00', '2023-07-16 16:30:34', 'ANALISIS DAN PERANCANGAN SISTEM INFORMASI 1', 1, 'PSI3401', 2, 4, 'aktif');
INSERT INTO `mata_kuliahs` VALUES (15, '2023-07-09 06:26:15', '2023-07-16 16:30:39', 'PEMROGRAMAN WEB', 1, 'PSI3403', 3, 4, 'aktif');
INSERT INTO `mata_kuliahs` VALUES (16, '2023-07-09 06:26:28', '2023-07-16 16:30:45', 'PROJEK 2', 1, 'PMI0005', 4, 4, 'aktif');
INSERT INTO `mata_kuliahs` VALUES (17, '2023-07-09 06:27:00', '2023-07-16 16:30:51', 'SISTEM PENGAMBIL KEPUTUSAN', 1, 'PSI3504', 3, 5, 'aktif');
INSERT INTO `mata_kuliahs` VALUES (18, '2023-07-09 06:27:18', '2023-07-16 16:30:59', 'ANALISIS DAN PERANCANGAN SISTEM INFORMASI 2', 1, 'PSI3501', 5, 5, 'aktif');
INSERT INTO `mata_kuliahs` VALUES (19, '2023-07-09 06:27:48', '2023-07-16 16:31:05', 'DATA MINING', 1, 'PSI3502', 3, 5, 'aktif');
INSERT INTO `mata_kuliahs` VALUES (20, '2023-07-09 06:28:06', '2023-07-16 16:31:10', 'MANAJEMEN PROYEK', 1, 'PSI6602', 3, 6, 'aktif');
INSERT INTO `mata_kuliahs` VALUES (21, '2023-07-09 06:28:28', '2023-07-16 16:31:15', 'KEWIRAUSAHAAN', 1, 'PSI6601', 3, 6, 'aktif');
INSERT INTO `mata_kuliahs` VALUES (22, '2023-07-09 06:28:40', '2023-07-16 16:31:21', 'ECOMMERCE', 1, 'PSI6604', 4, 6, 'aktif');

-- ----------------------------
-- Table structure for migrations
-- ----------------------------
DROP TABLE IF EXISTS `migrations`;
CREATE TABLE `migrations`  (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `migration` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 30 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of migrations
-- ----------------------------
INSERT INTO `migrations` VALUES (1, '2014_10_12_000000_create_users_table', 1);
INSERT INTO `migrations` VALUES (2, '2023_05_10_141547_create_roles_table', 1);
INSERT INTO `migrations` VALUES (3, '2023_06_14_022801_create_jurusans_table', 1);
INSERT INTO `migrations` VALUES (4, '2023_06_14_022906_create_tahun_ajarans_table', 1);
INSERT INTO `migrations` VALUES (5, '2023_06_14_022928_create_program_studis_table', 1);
INSERT INTO `migrations` VALUES (6, '2023_06_14_022950_create_mata_kuliahs_table', 1);
INSERT INTO `migrations` VALUES (7, '2023_06_14_023024_create_nilais_table', 1);
INSERT INTO `migrations` VALUES (8, '2023_06_14_023049_create_kehadirans_table', 1);
INSERT INTO `migrations` VALUES (9, '2023_06_14_023151_create_jadwals_table', 1);
INSERT INTO `migrations` VALUES (10, '2023_06_14_023224_create_mata_kuliah_enrolls_table', 1);
INSERT INTO `migrations` VALUES (11, '2023_06_14_023243_create_kelas_table', 1);
INSERT INTO `migrations` VALUES (12, '2023_06_14_023301_create_kelas_enrolls_table', 1);
INSERT INTO `migrations` VALUES (13, '2023_06_15_051738_create_mahasiswa_mata_kuliah_enrolls_table', 1);
INSERT INTO `migrations` VALUES (14, '2023_06_16_032217_daftar_nilai', 1);
INSERT INTO `migrations` VALUES (15, '2023_06_19_012224_create_perwalians_table', 1);
INSERT INTO `migrations` VALUES (16, '2023_07_02_025320_modify_mata_kuliah_enrolls_table', 1);
INSERT INTO `migrations` VALUES (17, '2023_07_02_030837_create_sp_table', 1);
INSERT INTO `migrations` VALUES (18, '2023_07_03_041513_add_judul_nilai_to_daftar_nilai_table', 1);
INSERT INTO `migrations` VALUES (19, '2023_07_03_095840_change_status_at_kehadirans_table', 1);
INSERT INTO `migrations` VALUES (20, '2023_07_03_140800_create_orang_tua_table', 1);
INSERT INTO `migrations` VALUES (21, '2023_07_05_041548_modify_sp_table', 1);
INSERT INTO `migrations` VALUES (22, '2023_07_07_175656_add_status_at_mata_kuliah_table', 2);
INSERT INTO `migrations` VALUES (23, '2023_07_07_181528_add_status_at_kelas_table', 2);
INSERT INTO `migrations` VALUES (24, '2023_07_09_094302_modify_jadwal_table', 2);
INSERT INTO `migrations` VALUES (25, '2023_07_09_095301_add_terlambat_at_kehadiran', 2);
INSERT INTO `migrations` VALUES (26, '2023_07_10_173005_modify_kehadirans_table', 2);
INSERT INTO `migrations` VALUES (27, '2023_07_12_165357_add_semester_at_mata_kuliah', 3);
INSERT INTO `migrations` VALUES (28, '2023_07_13_120608_modify_nilai', 3);
INSERT INTO `migrations` VALUES (29, '2023_07_15_173205_modifify_kelas_table', 3);

-- ----------------------------
-- Table structure for nilais
-- ----------------------------
DROP TABLE IF EXISTS `nilais`;
CREATE TABLE `nilais`  (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `id_daftar_nilai` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `id_mahasiswa` int NULL DEFAULT NULL,
  `nilai` double NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 129 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of nilais
-- ----------------------------

-- ----------------------------
-- Table structure for orang_tua
-- ----------------------------
DROP TABLE IF EXISTS `orang_tua`;
CREATE TABLE `orang_tua`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `id_mahasiswa` int UNSIGNED NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `nim_mahasiswa` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `address` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `phone_number` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `gender` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `orang_tua_email_unique`(`email`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of orang_tua
-- ----------------------------
INSERT INTO `orang_tua` VALUES (1, 11, 'Ides Legiatawi', 'legiawati@gmail.com', '10107040', '$2y$10$i6T10.fSRP0fHiM.RSi/WutH7JEa/iUmZokdJjBFiKwa25ggm/4Lm', 'Purwadadi Subang', '083195739340', 'Laki-laki', '2023-07-11 08:13:17', '2023-07-11 08:13:17');
INSERT INTO `orang_tua` VALUES (2, 20, 'Orang tua Taupik', 'orangtuataupik@gmail.com', '10107043', '$2y$10$6jpiduFaU1gZnl1tiJWRbO1NZUUQrpiHrauTxmg.PqClI7BZQWDnG', 'Jakarta', '083195739340', 'Laki-laki', '2023-07-13 10:31:17', '2023-07-13 10:31:17');

-- ----------------------------
-- Table structure for perwalians
-- ----------------------------
DROP TABLE IF EXISTS `perwalians`;
CREATE TABLE `perwalians`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `id_kelas` bigint UNSIGNED NOT NULL,
  `id_mahasiswa` bigint UNSIGNED NOT NULL,
  `keluhan` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `balasan` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of perwalians
-- ----------------------------

-- ----------------------------
-- Table structure for program_studis
-- ----------------------------
DROP TABLE IF EXISTS `program_studis`;
CREATE TABLE `program_studis`  (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `id_jurusan` int NULL DEFAULT NULL,
  `nama_prodi` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 7 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of program_studis
-- ----------------------------
INSERT INTO `program_studis` VALUES (1, NULL, '2023-07-09 04:29:03', 1, 'Sistem Informasi');
INSERT INTO `program_studis` VALUES (2, NULL, '2023-07-09 04:29:09', 1, 'Rekayasa Perangkat Lunak');
INSERT INTO `program_studis` VALUES (3, '2023-07-09 04:29:16', '2023-07-09 04:29:16', 4, 'Agroindustri');
INSERT INTO `program_studis` VALUES (4, '2023-07-09 04:29:22', '2023-07-09 04:29:22', 5, 'Keperawatan');
INSERT INTO `program_studis` VALUES (5, '2023-07-09 04:29:29', '2023-07-09 04:29:29', 6, 'Pemeliharaan Mesin');
INSERT INTO `program_studis` VALUES (6, '2023-07-09 04:29:47', '2023-07-09 04:29:47', 6, 'Teknologi Rekayasa Manufaktur');

-- ----------------------------
-- Table structure for roles
-- ----------------------------
DROP TABLE IF EXISTS `roles`;
CREATE TABLE `roles`  (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `role_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of roles
-- ----------------------------
INSERT INTO `roles` VALUES (1, NULL, NULL, 'admin polsub');
INSERT INTO `roles` VALUES (2, NULL, NULL, 'admin jurusan');
INSERT INTO `roles` VALUES (3, NULL, NULL, 'dosen');
INSERT INTO `roles` VALUES (4, NULL, NULL, 'mahasiswa');
INSERT INTO `roles` VALUES (5, NULL, NULL, 'orang tua');

-- ----------------------------
-- Table structure for sp
-- ----------------------------
DROP TABLE IF EXISTS `sp`;
CREATE TABLE `sp`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `id_kelas` int UNSIGNED NOT NULL,
  `deskripsi` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `id_user_penerima` int UNSIGNED NOT NULL,
  `file` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sp
-- ----------------------------

-- ----------------------------
-- Table structure for tahun_ajarans
-- ----------------------------
DROP TABLE IF EXISTS `tahun_ajarans`;
CREATE TABLE `tahun_ajarans`  (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `tahun` int NULL DEFAULT NULL,
  `semester` int NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 13 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of tahun_ajarans
-- ----------------------------
INSERT INTO `tahun_ajarans` VALUES (1, '2023-07-08 21:56:31', '2023-07-08 21:56:31', 2023, 1);
INSERT INTO `tahun_ajarans` VALUES (2, '2023-07-08 21:56:37', '2023-07-08 21:56:37', 2023, 2);
INSERT INTO `tahun_ajarans` VALUES (3, '2023-07-08 21:56:44', '2023-07-08 21:56:44', 2023, 3);
INSERT INTO `tahun_ajarans` VALUES (4, '2023-07-08 21:56:49', '2023-07-08 21:56:49', 2023, 4);
INSERT INTO `tahun_ajarans` VALUES (5, '2023-07-08 21:56:55', '2023-07-08 21:56:55', 2023, 5);
INSERT INTO `tahun_ajarans` VALUES (6, '2023-07-08 21:56:59', '2023-07-08 21:56:59', 2023, 6);
INSERT INTO `tahun_ajarans` VALUES (7, '2023-07-09 04:39:58', '2023-07-09 05:38:01', 2022, 1);
INSERT INTO `tahun_ajarans` VALUES (8, '2023-07-09 04:40:03', '2023-07-09 05:38:06', 2022, 2);
INSERT INTO `tahun_ajarans` VALUES (9, '2023-07-09 04:40:09', '2023-07-09 05:38:10', 2022, 3);
INSERT INTO `tahun_ajarans` VALUES (10, '2023-07-09 04:40:15', '2023-07-09 05:38:18', 2022, 4);
INSERT INTO `tahun_ajarans` VALUES (11, '2023-07-09 04:40:22', '2023-07-09 05:38:25', 2022, 5);
INSERT INTO `tahun_ajarans` VALUES (12, '2023-07-09 04:40:27', '2023-07-09 05:38:32', 2022, 6);

-- ----------------------------
-- Table structure for users
-- ----------------------------
DROP TABLE IF EXISTS `users`;
CREATE TABLE `users`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `identity_number` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `id_role` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `address` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `phone_number` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `gender` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `id_prodi` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `users_email_unique`(`email`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 32 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of users
-- ----------------------------
INSERT INTO `users` VALUES (6, 'Admin Jurusan Kesehatan', 'adminjurusankesehatan@gmail.com', '10101010', '2', '$2y$10$8zaC/IiXVZBCfkiv6aFGB.KfoBJmLDCQsIlcdm2qSEGx3DqQkM/36', 'Purwadadi Subang', '083195739340', 'Laki-laki', '4', '2023-07-09 04:42:31', '2023-07-09 04:42:46');
INSERT INTO `users` VALUES (7, 'Admin Jurusan Manajemen Informatika', 'adminjurusanmi@gmail.com', '20202020', '2', '$2y$10$x8J1.QvccnGEZr9FyztQvOquLvYcpUY393CbswBxcxop8eUcFUs.G', 'Purwadadi Subang', '083195739340', 'Laki-laki', '1', '2023-07-09 04:43:41', '2023-07-09 04:43:41');
INSERT INTO `users` VALUES (8, 'Admin Jurusan Agroindustri', 'adminjurusanagro@gmail.com', '30303030', '2', '$2y$10$9bFXUjyF/MCqefHUMLseBeWryT.6gyMrIznv8YtjSXq4R/GGqeD8y', 'Purwadadi Subang', '083195739340', 'Laki-laki', '3', '2023-07-09 04:44:34', '2023-07-09 04:44:34');
INSERT INTO `users` VALUES (10, 'Admin Jurusan Teknik Perawatan dan Perbaikan Mesin', 'adminjurusanmesin@gmail.com', '40404040', '2', '$2y$10$eUeA7Fgdn2mWHgBAWBNxyutpCKjvH/AS9QVWEhJktHweKnJWme/Ea', 'Purwadadi Subang', '083195739340', 'Laki-laki', '5', '2023-07-09 04:47:11', '2023-07-09 04:47:11');
INSERT INTO `users` VALUES (11, 'Muhammad Elang Belanegara', 'muhammadelang030415@gmail.com', '10107040', '4', '$2y$10$umpee6Z3tt4NaMBBxMSDROUz17FR/HsYLsAle.MwvUPQ46fUiwb/q', 'Purwadadi Subang', '083195739340', 'Laki-laki', '1', '2023-07-09 04:52:03', '2023-07-09 04:52:03');
INSERT INTO `users` VALUES (12, 'Beni Nuryahya', 'beninuryahya@gmail.com', '10107012', '4', '$2y$10$sREQZcynYvh.r13YRY2xEeTSiIq7bwvXAfh67GFynHc/WcVEXMaK2', 'Purwadadi Subang', '083195739340', 'Laki-laki', '1', '2023-07-09 04:52:57', '2023-07-09 04:52:57');
INSERT INTO `users` VALUES (13, 'Putri Fitriani', 'putrifitriani@gmail.com', '10107046', '4', '$2y$10$WfI6SkD7G6EWAZC2pdGU5urxBJqh0fThSbOaktWCwSn4D3hDH64Gi', 'Purwadadi Subang', '083195739340', 'Perempuan', '1', '2023-07-09 04:53:37', '2023-07-09 04:53:37');
INSERT INTO `users` VALUES (14, 'Teresia Fransiska', 'Teresiafransiska@gmail.com', '10107060', '4', '$2y$10$P7R/W8JHPFiHhogHOeQCHecL6/0KrXM/x67Ct8dY0bjZEtPBfrcru', 'Purwadadi Subang', '083195739340', 'Perempuan', '1', '2023-07-09 04:54:31', '2023-07-09 04:54:31');
INSERT INTO `users` VALUES (15, 'Muhammad Rafki Fauz Nasywa', 'muhammadrafki@gmail.com', '10107042', '4', '$2y$10$AsvKJxtXs57V/l2m59KMdu463uryCaOh3x18A3Rfmuuirc4heiBwm', 'Purwadadi Subang', '083195739340', 'Laki-laki', '1', '2023-07-09 04:55:09', '2023-07-09 04:55:09');
INSERT INTO `users` VALUES (16, 'Farras Insan Nurhidayat', 'farrasinsan@gmail.com', '10107028', '4', '$2y$10$obVFp2cQED/jONJqkC3SdukULUXmksSkScij74W7DEhWdcck/.wEi', 'Purwadadi Subang', '83195739339', 'Laki-laki', '1', '2023-07-09 04:55:46', '2023-07-09 04:55:46');
INSERT INTO `users` VALUES (17, 'Renaldi Noviandi', 'renaldinoviandi@gmail.com', '10107050', '4', '$2y$10$5KQr2993hxughafOFAewreKn98retAK6bCK9Xk5NA28Tyq2td1dZy', 'Purwadadi Subang', '083195739340', 'Laki-laki', '1', '2023-07-09 04:56:24', '2023-07-09 04:56:24');
INSERT INTO `users` VALUES (18, 'Fajar Gunawan', 'fajargunawan@gmail.com', '10107026', '4', '$2y$10$GG2VvU6BgfBWyO5YMGLat.llQsfpSWownJacUfkc9RbWrKKBdhHgC', 'Purwadadi Subang', '083195739340', 'Laki-laki', '1', '2023-07-09 04:57:55', '2023-07-09 04:57:55');
INSERT INTO `users` VALUES (19, 'Adi Sudrajat', 'adisudrajat@gmail.com', '10107002', '4', '$2y$10$rycdnnm6IL7teB4QNcUS4Oqn1GSEJkhI6Os77fYJzANqSmQBDZTii', 'Purwadadi Subang', '083195739340', 'Laki-laki', '1', '2023-07-09 04:58:43', '2023-07-09 04:58:43');
INSERT INTO `users` VALUES (20, 'Taupik Herdiansyah', 'taupikherdiansyah@gmail.com', '10107043', '4', '$2y$10$U8LYZOYMs4tFrxwGjijFO.x3di9kr4KohjyutfDk1y4nfWFILtxjO', 'Purwadadi Subang', '083195739340', 'Laki-laki', '1', '2023-07-09 04:59:25', '2023-07-09 04:59:25');
INSERT INTO `users` VALUES (21, 'Nunu Nugraha P., S.Pd., M.Kom.', 'dosennunu@gmail.com', '197909152015041001', '3', '$2y$10$lnVRb66AHCCOkKnoODgcIexDR7H1DSf7w7O7MEpLWp5TVn72eSZrS', 'Purwadadi Subang', '083195739340', 'Laki-laki', '1', '2023-07-09 05:29:53', '2023-07-09 05:29:53');
INSERT INTO `users` VALUES (22, 'Tri Herdiawan A., S.ST., M.T.', 'dosentri@gmail.com', '198801052019031008', '3', '$2y$10$pgGbF.b0.O1Oh7EaXKTnWeL60Q6T85OHZ3c9Kp6.khw1p5tTTbUnO', 'Purwadadi Subang', '083195739340', 'Laki-laki', '1', '2023-07-09 05:30:54', '2023-07-09 05:30:54');
INSERT INTO `users` VALUES (23, 'Rian Piarna, S.E., MM.', 'dosenrian@gmail.com', '198709032019031009', '3', '$2y$10$kbKWIPXW2LTyZ0yfq5edNeVJsz8avcU4dc08.wvlxmAgGc6Wl8CTK', 'Purwadadi Subang', '083195739340', 'Laki-laki', '1', '2023-07-09 05:31:37', '2023-07-09 05:31:37');
INSERT INTO `users` VALUES (24, 'Mohammad Iqbal, S.Kom., M.T.', 'doseniqbal@gmail.com', '199001262019031025', '3', '$2y$10$ZGVGJ/i2HUOEVABT9rA1JueEk.U2S6oP1jtJvsBMi8Ryxdxsb2HPS', 'Purwadadi Subang', '083195739340', 'Laki-laki', '1', '2023-07-09 05:32:14', '2023-07-09 05:32:14');
INSERT INTO `users` VALUES (25, 'Dwi Vernanda, S.T., M.Pd.', 'dosendwi@gmail.com', '199104302019032018', '3', '$2y$10$PA87Ay9Lmt6nCe9XnBFf9uAuReGUHMUMSIwYBYhshGmboN.HVEBeG', 'Purwadadi Subang', '083195739340', 'Laki-laki', '1', '2023-07-09 05:33:04', '2023-07-09 05:33:04');
INSERT INTO `users` VALUES (26, 'Slamet Rahayu, S.Pd., M.Pd.', 'dosenslamet@gmail.com', '170900045', '3', '$2y$10$FZOxBs/rcUzbpwVbpNjCMeJNuvgycqr6Infpn8fdppvifyjGmxc7G', 'Purwadadi Subang', '083195739340', 'Laki-laki', '1', '2023-07-09 05:33:39', '2023-07-09 05:33:39');
INSERT INTO `users` VALUES (27, 'Lani Nurlani, S.T., M.Kom', 'dosenlani@gmail.com', '198803042022032002', '3', '$2y$10$x.V0lJI0EUcN2kjOb9ktfep2xnnoLkBKE23/fakapu2dZ5d8yt5Gy', 'Purwadadi Subang', '083195739340', 'Perempuan', '1', '2023-07-09 05:35:07', '2023-07-09 05:35:07');
INSERT INTO `users` VALUES (28, 'Nurfitria Khoirunnisa, S.Tr.Kom., M.Kom.', 'dosennurfitria@gmail.com', '199603112020122022', '3', '$2y$10$pSiZF5C8HIfNb0LsTQa9eO3ApyCYA0fTZLrkHhQB5wbWhSod7Vbyy', 'Purwadadi Subang', '083195739340', 'Perempuan', '1', '2023-07-09 05:35:44', '2023-07-09 05:35:44');
INSERT INTO `users` VALUES (29, 'Sari Azhariyah, S.Pd, M.Pd.T', 'dosensari@gmail.com', '199408182022032017', '3', '$2y$10$4/XbRjorAUDrN6DLyBiOqec6BxKh2RX5AgDNDrFPRpsEnJG0tyXou', 'Purwadadi Subang', '083195739340', 'Laki-laki', '1', '2023-07-09 05:36:27', '2023-07-09 05:36:27');
INSERT INTO `users` VALUES (30, 'Taufan Abdurrachman, S.T., M.Kom', 'dosentaufan@gmail.com', '199311112022031006', '3', '$2y$10$MqcI7F5mvACJc3CYBDuQzOLXBVXYYOP5IQOm1uuMINa10IjFmUxLa', 'Purwadadi Subang', '083195739340', 'Laki-laki', '1', '2023-07-09 05:37:13', '2023-07-09 05:37:13');
INSERT INTO `users` VALUES (31, 'Admin Politeknik Negeri Subang', 'adminpolsub@gmail.com', '10101010', '1', '$2y$10$/MN9us3irCPntnaDY7WKwOf2vhXJbLhcGNKrmkdEC9SqutDyQxe0O', 'Purwadadi Subang', '083195739340', 'Laki-laki', '1', '2023-07-09 05:44:30', '2023-07-09 05:45:44');

SET FOREIGN_KEY_CHECKS = 1;
