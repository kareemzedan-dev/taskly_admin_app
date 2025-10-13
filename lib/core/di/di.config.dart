// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i361;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:supabase_flutter/supabase_flutter.dart' as _i454;

import '../../features/attachments/data/data_sources/remote/attachments_remote_data_source/attachments_remote_data_source.dart'
    as _i1020;
import '../../features/attachments/data/data_sources_impl/remote/attachments_remote_data_source_impl/attachments_remote_data_source_impl.dart'
    as _i568;
import '../../features/attachments/data/repositories/attachments_repository_impl/attachments_repository_impl.dart'
    as _i727;
import '../../features/attachments/domain/repositories/attachments_repository/attachments_repository.dart'
    as _i345;
import '../../features/attachments/domain/use_cases/delete_attachments/delete_attachments_use_case.dart'
    as _i416;
import '../../features/attachments/domain/use_cases/download_attachments/download_attachments.dart'
    as _i197;
import '../../features/attachments/domain/use_cases/upload_attachments/upload_attachments_use_case.dart'
    as _i231;
import '../../features/attachments/presentation/manager/delete_attachments_view_model/delete_attachments_view_model.dart'
    as _i195;
import '../../features/attachments/presentation/manager/download_attachments_view_model/download_attachments_view_model.dart'
    as _i338;
import '../../features/attachments/presentation/manager/upload_attachments_view_model/upload_attachments_view_model.dart'
    as _i11;
import '../../features/auth/data/data_sources/remote/auth_remote_data_source.dart'
    as _i432;
import '../../features/auth/data/data_sources_impl/remote/auth_remote_data_source_impl.dart'
    as _i420;
import '../../features/auth/data/repos_impl/auth/auth_repo_impl.dart' as _i529;
import '../../features/auth/domain/repos/auth/auth_repo.dart' as _i746;
import '../../features/auth/domain/use_cases/auth/auth_use_case.dart' as _i630;
import '../../features/auth/presentation/cubit/auth_view_model.dart' as _i745;
import '../../features/home/data/data_sources/remote/messages_remote_data_sources/delete_message_remote_data_source/delete_message_remote_data_source.dart'
    as _i295;
import '../../features/home/data/data_sources/remote/messages_remote_data_sources/get_accepted_order_messages_remote_data_source/get_accepted_order_messages_remote_data_source.dart'
    as _i528;
import '../../features/home/data/data_sources/remote/messages_remote_data_sources/get_admin_conversations_remote_data_source/get_admin_conversations_remote_data_source.dart'
    as _i159;
import '../../features/home/data/data_sources/remote/messages_remote_data_sources/get_chat_messages_remote_data_source_impl/get_chat_messages_remote_data_source.dart'
    as _i161;
import '../../features/home/data/data_sources/remote/messages_remote_data_sources/mark_messages_as_read_remote_data_source_impl/mark_messages_as_read_remote_data_source.dart'
    as _i107;
import '../../features/home/data/data_sources/remote/messages_remote_data_sources/send_message_remote_data_source_impl/send_message_remote_data_source.dart'
    as _i901;
import '../../features/home/data/data_sources/remote/messages_remote_data_sources/subscribe_to_messages_remote_data_source_impl/subscribe_to_messages_remote_data_source.dart'
    as _i499;
import '../../features/home/data/data_sources/remote/messages_remote_data_sources/user_status_remote_data_source/user_status_remote_data_source.dart'
    as _i746;
import '../../features/home/data/data_sources/remote/offers/subscribe_to_offers_remote_data_source/subscribe_to_offers_remote_data_source.dart'
    as _i347;
import '../../features/home/data/data_sources/remote/orders/category_distribution_remote_data_source/category_distribution_remote_data_source.dart'
    as _i39;
import '../../features/home/data/data_sources/remote/orders/get_all_orders_remote_data_source/get_all_orders_remote_data_source.dart'
    as _i172;
import '../../features/home/data/data_sources/remote/orders/get_order_by_id_remote_data_source/get_order_by_id_remote_data_source.dart'
    as _i669;
import '../../features/home/data/data_sources/remote/orders/get_orders_conversions_remote_data_source/get_orders_conversions_remote_data_source.dart'
    as _i7;
import '../../features/home/data/data_sources/remote/orders/late_orders_remote_data_source/late_orders_remote_data_source.dart'
    as _i648;
import '../../features/home/data/data_sources/remote/orders/subscribe_to_orders_remote_data_source/subscribe_to_orders_remote_data_source.dart'
    as _i985;
import '../../features/home/data/data_sources/remote/orders/update_order_status_remote_data_source/update_order_status_remote_data_source.dart'
    as _i992;
import '../../features/home/data/data_sources/remote/payments/add_commission_remote_data_source/add_commission_remote_data_source.dart'
    as _i133;
import '../../features/home/data/data_sources/remote/payments/bank_accounts_remote_data_source/bank_accounts_remote_data_source.dart'
    as _i14;
import '../../features/home/data/data_sources/remote/payments/payments_admin_remote_data_source/payments_admin_remote_data_source.dart'
    as _i278;
import '../../features/home/data/data_sources/remote/payments/payments_realtime_remote_data_source/payments_realtime_remote_data_source.dart'
    as _i28;
import '../../features/home/data/data_sources/remote/payments/payments_user_remote_data_source/payments_user_remote_data_source.dart'
    as _i401;
import '../../features/home/data/data_sources/remote/payments/pending_payments_remote_data_source/pending_payments_remote_data_source.dart'
    as _i589;
import '../../features/home/data/data_sources/remote/payments/update_payment_status_remote_data_source/update_payment_status_remote_data_source.dart'
    as _i557;
import '../../features/home/data/data_sources/remote/users/get_all_users_remote_data_source/get_all_users_remote_data_source.dart'
    as _i976;
import '../../features/home/data/data_sources/remote/users/get_user_info_by_id_data_source/get_user_info_by_id_data_source.dart'
    as _i5;
import '../../features/home/data/data_sources/remote/users/pending_verifications_remote_data_source/pending_verifications_remote_data_source.dart'
    as _i972;
import '../../features/home/data/data_sources/remote/users/update_user_status_remote_data_source/update_user_status_remote_data_source.dart'
    as _i575;
import '../../features/home/data/data_sources_impl/remote/messages/delete_message_remote_data_source_impl/delete_message_remote_data_source_impl.dart'
    as _i279;
import '../../features/home/data/data_sources_impl/remote/messages/get_accepted_order_messages_remote_data_source_impl/get_accepted_order_messages_remote_data_source_impl.dart'
    as _i567;
import '../../features/home/data/data_sources_impl/remote/messages/get_chat_messages_remote_data_source_impl/get_chat_messages_remote_data_source_impl.dart'
    as _i141;
import '../../features/home/data/data_sources_impl/remote/messages/get_conversations_remote_data_source_impl/get_conversations_remote_data_source_impl.dart'
    as _i876;
import '../../features/home/data/data_sources_impl/remote/messages/mark_messages_as_read_remote_data_source_impl/mark_messages_as_read_remote_data_source_impl.dart'
    as _i1046;
import '../../features/home/data/data_sources_impl/remote/messages/send_message_remote_data_source_impl/send_message_remote_data_source_impl.dart'
    as _i540;
import '../../features/home/data/data_sources_impl/remote/messages/subscribe_to_messages_remote_data_source_impl/subscribe_to_messages_remote_data_source_impl.dart'
    as _i535;
import '../../features/home/data/data_sources_impl/remote/messages/user_status_remote_data_source_impl/user_status_remote_data_source_impl.dart'
    as _i120;
import '../../features/home/data/data_sources_impl/remote/offers/subscribe_to_offers_remote_data_source_impl/subscribe_to_offers_remote_data_source_impl.dart'
    as _i1057;
import '../../features/home/data/data_sources_impl/remote/orders/category_distribution_remote_data_source_impl/category_distribution_remote_data_source_impl.dart'
    as _i952;
import '../../features/home/data/data_sources_impl/remote/orders/get_all_orders_remote_data_source_impl/get_all_orders_remote_data_source_impl.dart'
    as _i695;
import '../../features/home/data/data_sources_impl/remote/orders/get_order_by_id_remote_data_source_impl/get_order_by_id_remote_data_source_impl.dart'
    as _i737;
import '../../features/home/data/data_sources_impl/remote/orders/get_orders_conversions_remote_data_source_impl/get_orders_conversions_remote_data_source_impl.dart'
    as _i451;
import '../../features/home/data/data_sources_impl/remote/orders/late_orders_remote_data_source_impl/late_orders_remote_data_source_impl.dart'
    as _i328;
import '../../features/home/data/data_sources_impl/remote/orders/subscribe_to_orders_remote_data_source_impl/subscribe_to_orders_remote_data_source_impl.dart'
    as _i130;
import '../../features/home/data/data_sources_impl/remote/orders/update_order_status_remote_data_source_impl/update_order_status_remote_data_source_impl.dart'
    as _i834;
import '../../features/home/data/data_sources_impl/remote/payments/add_commission_remote_data_source_impl/add_commission_remote_data_source_impl.dart'
    as _i573;
import '../../features/home/data/data_sources_impl/remote/payments/bank_accounts_remote_data_source_impl/bank_accounts_remote_data_source_impl.dart'
    as _i436;
import '../../features/home/data/data_sources_impl/remote/payments/payments_admin_remote_data_source_impl/payments_admin_remote_data_source_impl.dart'
    as _i1027;
import '../../features/home/data/data_sources_impl/remote/payments/payments_realtime_remote_data_source_impl/payments_realtime_remote_data_source_impl.dart'
    as _i779;
import '../../features/home/data/data_sources_impl/remote/payments/payments_user_remote_data_source_impl/payments_user_remote_data_source_impl.dart'
    as _i558;
import '../../features/home/data/data_sources_impl/remote/payments/pending_payments_remote_data_source_impl/pending_payments_remote_data_source_impl.dart'
    as _i642;
import '../../features/home/data/data_sources_impl/remote/payments/update_payment_status_remote_data_source_impl/update_payment_status_remote_data_source_impl.dart'
    as _i134;
import '../../features/home/data/data_sources_impl/remote/users/get_all_users_remote_data_source_impl/get_all_users_remote_data_source_impl.dart'
    as _i79;
import '../../features/home/data/data_sources_impl/remote/users/get_user_info_by_id_data_source_impl/get_user_info_by_id_data_source_impl.dart'
    as _i131;
import '../../features/home/data/data_sources_impl/remote/users/pending_verifications_remote_data_source_impl/pending_verifications_remote_data_source_impl.dart'
    as _i532;
import '../../features/home/data/data_sources_impl/remote/users/update_user_status_remote_data_source_impl/update_user_status_remote_data_source_impl.dart'
    as _i362;
import '../../features/home/data/repos_impl/accounts_bank_repos_impl/accounts_bank_repos_impl.dart'
    as _i739;
import '../../features/home/data/repos_impl/category_distribution_repo_impl/category_distribution_repo_impl.dart'
    as _i405;
import '../../features/home/data/repos_impl/dashboard_repos_impl/dashboard_repos_impl.dart'
    as _i823;
import '../../features/home/data/repos_impl/late_orders_repo_impl/late_orders_repo_impl.dart'
    as _i469;
import '../../features/home/data/repos_impl/messages_repos_impl/delete_message_repo_impl/delete_message_repo_impl.dart'
    as _i474;
import '../../features/home/data/repos_impl/messages_repos_impl/get_admin_conversions_repo_impl/get_conversions_repo_impl.dart'
    as _i846;
import '../../features/home/data/repos_impl/messages_repos_impl/get_all_order_messages_repo_impl/get_all_order_messages_repo_impl.dart'
    as _i707;
import '../../features/home/data/repos_impl/messages_repos_impl/get_messages_repo_impl/get_messages_repo_impl.dart'
    as _i364;
import '../../features/home/data/repos_impl/messages_repos_impl/get_orders_conversions_repo_impl/get_orders_conversions_repo_impl.dart'
    as _i902;
import '../../features/home/data/repos_impl/messages_repos_impl/mark_message_as_read_repo_impl/mark_message_as_read_repo_impl.dart'
    as _i969;
import '../../features/home/data/repos_impl/messages_repos_impl/send_messages_repo_impl/send_messages_repo_impl.dart'
    as _i192;
import '../../features/home/data/repos_impl/messages_repos_impl/subscribe_to_messages_repo_impl/subscribe_to_messages_repo_impl.dart'
    as _i24;
import '../../features/home/data/repos_impl/messages_repos_impl/user_status_repo_impl/user_status_repo_impl.dart'
    as _i790;
import '../../features/home/data/repos_impl/orders_repos_impl/orders_repos_impl.dart'
    as _i163;
import '../../features/home/data/repos_impl/payments_repos_impl/payments_repos_impl.dart'
    as _i116;
import '../../features/home/data/repos_impl/pending_payments_repo_impl/pending_payments_repo_impl.dart'
    as _i77;
import '../../features/home/data/repos_impl/pending_verifications_repo_impl/pending_verifications_repo_impl.dart'
    as _i216;
import '../../features/home/data/repos_impl/update_order_status_repo_impl/update_order_status_repo_impl.dart'
    as _i265;
import '../../features/home/data/repos_impl/users_repos_impl/users_repos_impl.dart'
    as _i840;
import '../../features/home/domain/repos/bank_account_repos/bank_account_repos.dart'
    as _i1069;
import '../../features/home/domain/repos/category_distribution_repo/category_distribution_repo.dart'
    as _i683;
import '../../features/home/domain/repos/dashboard/dashboard_repos.dart'
    as _i499;
import '../../features/home/domain/repos/late_orders_repo/late_orders_repo.dart'
    as _i358;
import '../../features/home/domain/repos/messages_repos/delete_message_repo/delete_message_repo.dart'
    as _i304;
import '../../features/home/domain/repos/messages_repos/get_admin_conversions_repo/get_admin_conversions_repo.dart'
    as _i637;
import '../../features/home/domain/repos/messages_repos/get_all_order_messages_repo/get_all_order_messages_repo.dart'
    as _i888;
import '../../features/home/domain/repos/messages_repos/get_messages_repo/get_messages_repo.dart'
    as _i641;
import '../../features/home/domain/repos/messages_repos/get_orders_conversions_repo/get_orders_conversions_repo.dart'
    as _i183;
import '../../features/home/domain/repos/messages_repos/mark_message_as_read_repo/mark_message_as_read_repo.dart'
    as _i92;
import '../../features/home/domain/repos/messages_repos/send_messages_repo/send_messages_repo.dart'
    as _i369;
import '../../features/home/domain/repos/messages_repos/subscribe_to_messages_repo/subscribe_to_messages_repo.dart'
    as _i625;
import '../../features/home/domain/repos/messages_repos/user_status_repo/user_status_repo.dart'
    as _i14;
import '../../features/home/domain/repos/orders/orders_repos.dart' as _i343;
import '../../features/home/domain/repos/payments_repos/payments_repos.dart'
    as _i492;
import '../../features/home/domain/repos/pending_payments_repo/pending_payments_repo.dart'
    as _i688;
import '../../features/home/domain/repos/pending_verifications_repo/pending_verifications_repo.dart'
    as _i256;
import '../../features/home/domain/repos/update_order_status_repo/update_order_status_repo.dart'
    as _i799;
import '../../features/home/domain/repos/users/users_repos.dart' as _i168;
import '../../features/home/domain/use_cases/add_bank_account_use_case/add_bank_account_use_case.dart'
    as _i808;
import '../../features/home/domain/use_cases/add_commission_use_case/add_commission_use_case.dart'
    as _i40;
import '../../features/home/domain/use_cases/category_distribution_use_case/category_distribution_use_case.dart'
    as _i660;
import '../../features/home/domain/use_cases/delete_bank_account_use_case/delete_bank_account_use_case.dart'
    as _i635;
import '../../features/home/domain/use_cases/delete_message_use_case/delete_message_use_case.dart'
    as _i892;
import '../../features/home/domain/use_cases/get_accepted_order_message_use_case/get_accepted_order_message_use_case.dart'
    as _i1055;
import '../../features/home/domain/use_cases/get_all_orders_use_case/get_all_orders_use_case.dart'
    as _i122;
import '../../features/home/domain/use_cases/get_all_payments_use_case/get_all_payments_use_case.dart'
    as _i648;
import '../../features/home/domain/use_cases/get_all_users_use_case/get_all_users_use_case.dart'
    as _i199;
import '../../features/home/domain/use_cases/get_bank_accounts_use_case/get_bank_accounts_use_case.dart'
    as _i999;
import '../../features/home/domain/use_cases/get_conversations_use_case/get_conversations_use_case.dart'
    as _i881;
import '../../features/home/domain/use_cases/get_late_orders_use_case/get_late_orders_use_case.dart'
    as _i222;
import '../../features/home/domain/use_cases/get_order_messages_use_case/get_order_messages_use_case.dart'
    as _i263;
import '../../features/home/domain/use_cases/get_orders_conversions_use_case/get_orders_conversions_use_case.dart'
    as _i472;
import '../../features/home/domain/use_cases/get_pending_payments_use_case/get_pending_payments_use_case.dart'
    as _i784;
import '../../features/home/domain/use_cases/get_pending_verifications_use_case/get_pending_verifications_use_case.dart'
    as _i223;
import '../../features/home/domain/use_cases/get_user_info_by_id_use_case/get_user_info_by_id_use_case.dart'
    as _i970;
import '../../features/home/domain/use_cases/get_user_payments_use_case/get_user_payments_use_case.dart'
    as _i579;
import '../../features/home/domain/use_cases/mark_message_read_use_case/mark_message_read_use_case.dart'
    as _i869;
import '../../features/home/domain/use_cases/order_by_user_use_case/order_by_user_use_case.dart'
    as _i287;
import '../../features/home/domain/use_cases/send_message_use_case/send_message_use_case.dart'
    as _i621;
import '../../features/home/domain/use_cases/subscribe_to_offers_use_case/subscribe_to_offers_use_case.dart'
    as _i298;
import '../../features/home/domain/use_cases/subscribe_to_orders_use_case/subscribe_to_orders_use_case.dart'
    as _i286;
import '../../features/home/domain/use_cases/subscribe_to_payments_use_case/subscribe_to_payments_use_case.dart'
    as _i547;
import '../../features/home/domain/use_cases/update_bank_account_status_use_case/update_bank_account_status_use_case.dart'
    as _i349;
import '../../features/home/domain/use_cases/update_bank_account_use_case/update_bank_account_use_case.dart'
    as _i165;
import '../../features/home/domain/use_cases/update_order_status_use_case/update_order_status_use_case.dart'
    as _i601;
import '../../features/home/domain/use_cases/update_payment_status_use_case/update_payment_status_use_case.dart'
    as _i1048;
import '../../features/home/domain/use_cases/update_user_status_use_case/update_user_status_use_case.dart'
    as _i842;
import '../../features/home/domain/use_cases/user_status_use_case/user_status_use_case.dart'
    as _i862;
import '../../features/home/presentation/views/tabs/dashboard/presentation/manager/add_commission_view_model/add_commission_view_model.dart'
    as _i215;
import '../../features/home/presentation/views/tabs/dashboard/presentation/manager/category_distribution_view_model/category_distribution_view_model.dart'
    as _i888;
import '../../features/home/presentation/views/tabs/dashboard/presentation/manager/get_all_orders_view_model/get_all_orders_view_model.dart'
    as _i737;
import '../../features/home/presentation/views/tabs/dashboard/presentation/manager/late_orders_view_model/late_orders_view_model.dart'
    as _i420;
import '../../features/home/presentation/views/tabs/dashboard/presentation/manager/pending_payments_view_model/pending_payments_view_model.dart'
    as _i579;
import '../../features/home/presentation/views/tabs/dashboard/presentation/manager/pending_verifications_view_case/pending_verifications_view_model.dart'
    as _i615;
import '../../features/home/presentation/views/tabs/messages/presentation/manager/get_accepted_order_message_view_model/get_accepted_order_message_view_model.dart'
    as _i1047;
import '../../features/home/presentation/views/tabs/messages/presentation/manager/get_conversations_view_model/get_conversations_view_model.dart'
    as _i56;
import '../../features/home/presentation/views/tabs/messages/presentation/manager/get_messages_view_model/get_messages_view_model.dart'
    as _i63;
import '../../features/home/presentation/views/tabs/messages/presentation/manager/get_orders_conversions_view_model/get_orders_conversions_view_model.dart'
    as _i996;
import '../../features/home/presentation/views/tabs/messages/presentation/manager/send_message_view_model/send_message_view_model.dart'
    as _i597;
import '../../features/home/presentation/views/tabs/messages/presentation/manager/user_status_view_model/user_status_view_model.dart'
    as _i252;
import '../../features/home/presentation/views/tabs/orders/presentation/manager/get_user_info_by_id_view_model/get_user_info_by_id_view_model.dart'
    as _i884;
import '../../features/home/presentation/views/tabs/orders/presentation/manager/subscribe_to_offers_view_model/subscribe_to_offers_view_model.dart'
    as _i948;
import '../../features/home/presentation/views/tabs/orders/presentation/manager/subscribe_to_orders_view_model/subscribe_to_orders_view_model.dart'
    as _i380;
import '../../features/home/presentation/views/tabs/orders/presentation/manager/update_order_status_view_model/update_order_status_view_model.dart'
    as _i295;
import '../../features/home/presentation/views/tabs/payments/presentation/manager/add_bank_acount_view_model/add_bank_acount_view_model.dart'
    as _i634;
import '../../features/home/presentation/views/tabs/payments/presentation/manager/admin_payments_view_model/admin_payments_view_model.dart'
    as _i190;
import '../../features/home/presentation/views/tabs/payments/presentation/manager/delete_bank_account_view_model/delete_bank_account_view_model.dart'
    as _i535;
import '../../features/home/presentation/views/tabs/payments/presentation/manager/get_bank_account_view_model/get_bank_account_view_model.dart'
    as _i79;
import '../../features/home/presentation/views/tabs/payments/presentation/manager/payments_view_model/payments_view_model.dart'
    as _i370;
import '../../features/home/presentation/views/tabs/payments/presentation/manager/subscribe_payments_view_model/subscribe_payments_view_model.dart'
    as _i934;
import '../../features/home/presentation/views/tabs/payments/presentation/manager/update_bank_account_status_view_model/update_bank_account_status_view_model.dart'
    as _i612;
import '../../features/home/presentation/views/tabs/payments/presentation/manager/update_bank_account_view_model/update_bank_account_view_model.dart'
    as _i258;
import '../../features/home/presentation/views/tabs/payments/presentation/manager/update_payment_status_view_model/update_payment_status_view_model.dart'
    as _i496;
import '../../features/home/presentation/views/tabs/payments/presentation/manager/user_payments_view_model/user_payments_view_model.dart'
    as _i1055;
import '../../features/home/presentation/views/tabs/users/presentation/manager/get_all_users_view_model/get_all_users_view_model.dart'
    as _i572;
import '../../features/home/presentation/views/tabs/users/presentation/manager/get_order_by_id_view_model/get_order_by_id_view_model.dart'
    as _i613;
import '../../features/home/presentation/views/tabs/users/presentation/manager/update_user_status_view_model/update_user_status_view_model.dart'
    as _i1066;
import '../../features/profile/data/data_sources/profile_remote_data_source.dart'
    as _i1012;
import '../../features/profile/data/data_sources_implem/profile_remote_data_source_impl.dart'
    as _i51;
import '../../features/profile/data/repositories/profile/profile_repo_impl.dart'
    as _i541;
import '../../features/profile/domain/repositories/profile/profile_repo.dart'
    as _i821;
import '../../features/profile/domain/use_cases/profile/profile_use_case.dart'
    as _i585;
import '../../features/profile/presentation/manager/profile_view_model/profile_view_model.dart'
    as _i1003;
import '../../features/reviews/data/data_sources/remote/reviews_remote_data_source/reviews_remote_data_source.dart'
    as _i114;
import '../../features/reviews/data/data_sources_impl/remote/reviews_remote_data_source_impl/reviews_remote_data_source_impl.dart'
    as _i716;
import '../../features/reviews/data/repositories/reviews_repo_impl/reviews_repo_impl.dart'
    as _i81;
import '../../features/reviews/domain/repositories/reviews_repo/reviews_repo.dart'
    as _i420;
import '../../features/reviews/domain/use_cases/delete_reviews_use_case/delete_reviews_use_case.dart'
    as _i985;
import '../../features/reviews/domain/use_cases/get_all_reviews_use_case/get_all_review_use_case.dart'
    as _i44;
import '../../features/reviews/domain/use_cases/get_user_reviews_use_case/get_user_reviews_use_case.dart'
    as _i701;
import '../../features/reviews/presentation/manager/delete_review_view_model/delete_review_view_model.dart'
    as _i842;
import '../../features/reviews/presentation/manager/get_all_reviews_view_model/get_all_reviews_view_model.dart'
    as _i580;
import '../../features/reviews/presentation/manager/get_user_reviews_view_model/get_user_reviews_view_model.dart'
    as _i163;
import '../services/file_uploaded_services.dart' as _i383;
import '../services/supabase_service.dart' as _i374;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    gh.singleton<_i383.FilePickerService>(() => _i383.FilePickerService());
    gh.factory<_i114.ReviewsRemoteDataSource>(
      () => _i716.ReviewsRemoteDataSourceImpl(gh<_i454.SupabaseClient>()),
    );
    gh.factory<_i1012.ProfileRemoteDataSource>(
      () => _i51.ProfileRemoteDataSourceImpl(gh<_i454.SupabaseClient>()),
    );
    gh.singleton<_i374.SupabaseService>(
      () => _i374.SupabaseService(gh<_i454.SupabaseClient>()),
      dispose: (i) => i.dispose(),
    );
    gh.factory<_i432.AuthRemoteDataSource>(
      () => _i420.AuthRemoteDataSourceImpl(),
    );
    gh.factory<_i972.PendingVerificationsRemoteDataSource>(
      () => _i532.PendingVerificationsRemoteDataSourceImpl(
        supabaseService: gh<_i374.SupabaseService>(),
      ),
    );
    gh.factory<_i1020.AttachmentsRemoteDataSource>(
      () => _i568.AttachmentsRemoteDataSourceImpl(
        gh<_i361.Dio>(),
        gh<_i374.SupabaseService>(),
        gh<_i454.SupabaseClient>(),
      ),
    );
    gh.factory<_i746.AuthRepo>(
      () => _i529.AuthRepoImpl(gh<_i432.AuthRemoteDataSource>()),
    );
    gh.factory<_i159.GetAdminConversationsRemoteDataSource>(
      () => _i876.GetConversationsRemoteDataSourceImpl(
        gh<_i374.SupabaseService>(),
      ),
    );
    gh.factory<_i14.BankAccountsRemoteDataSource>(
      () => _i436.BankAccountsRemoteDataSourceImpl(gh<_i374.SupabaseService>()),
    );
    gh.factory<_i557.UpdatePaymentStatusRemoteDataSource>(
      () => _i134.UpdatePaymentStatusRemoteDataSourceImpl(
        gh<_i374.SupabaseService>(),
      ),
    );
    gh.factory<_i278.PaymentsAdminRemoteDataSource>(
      () =>
          _i1027.PaymentsAdminRemoteDataSourceImpl(gh<_i374.SupabaseService>()),
    );
    gh.factory<_i420.ReviewsRepo>(
      () => _i81.ReviewsRepoImpl(
        remoteDataSource: gh<_i114.ReviewsRemoteDataSource>(),
      ),
    );
    gh.factory<_i7.GetOrdersConversionsRemoteDataSource>(
      () => _i451.GetOrdersConversionsRemoteDataSourceImpl(
        gh<_i374.SupabaseService>(),
      ),
    );
    gh.factory<_i985.DeleteReviewUseCase>(
      () => _i985.DeleteReviewUseCase(gh<_i420.ReviewsRepo>()),
    );
    gh.factory<_i44.GetAllReviewsUseCase>(
      () => _i44.GetAllReviewsUseCase(gh<_i420.ReviewsRepo>()),
    );
    gh.factory<_i701.GetUserReviewsUseCase>(
      () => _i701.GetUserReviewsUseCase(gh<_i420.ReviewsRepo>()),
    );
    gh.factory<_i172.GetAllOrdersRemoteDataSource>(
      () => _i695.GetAllOrdersRemoteDataSourceImpl(gh<_i374.SupabaseService>()),
    );
    gh.factory<_i976.GetAllUsersRemoteDataSource>(
      () => _i79.GetAllUsersRemoteDataSourceImpl(gh<_i374.SupabaseService>()),
    );
    gh.factory<_i107.MarkMessagesAsReadRemoteDataSource>(
      () => _i1046.MarkMessagesAsReadRemoteDataSourceImpl(
        gh<_i374.SupabaseService>(),
      ),
    );
    gh.factory<_i256.PendingVerificationsRepo>(
      () => _i216.PendingVerificationsRepoImpl(
        gh<_i972.PendingVerificationsRemoteDataSource>(),
      ),
    );
    gh.factory<_i842.DeleteReviewViewModel>(
      () => _i842.DeleteReviewViewModel(gh<_i985.DeleteReviewUseCase>()),
    );
    gh.factory<_i821.ProfileRepo>(
      () => _i541.ProfileRepoImpl(gh<_i1012.ProfileRemoteDataSource>()),
    );
    gh.factory<_i669.GetOrderByIdRemoteDataSource>(
      () => _i737.GetOrderByIdRemoteDataSourceImpl(gh<_i374.SupabaseService>()),
    );
    gh.factory<_i499.SubscribeToMessagesRemoteDataSource>(
      () => _i535.SubscribeToMessagesRemoteDataSourceImpl(
        gh<_i374.SupabaseService>(),
      ),
    );
    gh.factory<_i295.DeleteMessageRemoteDataSource>(
      () =>
          _i279.DeleteMessageRemoteDataSourceImpl(gh<_i374.SupabaseService>()),
    );
    gh.factory<_i589.PendingPaymentsRemoteDataSource>(
      () => _i642.PendingPaymentsRemoteDataSourceImpl(
        gh<_i374.SupabaseService>(),
      ),
    );
    gh.factory<_i630.AuthUseCase>(
      () => _i630.AuthUseCase(gh<_i746.AuthRepo>()),
    );
    gh.factory<_i992.UpdateOrderStatusRemoteDataSource>(
      () => _i834.UpdateOrderStatusRemoteDataSourceImpl(
        gh<_i374.SupabaseService>(),
      ),
    );
    gh.factory<_i746.UserStatusRemoteDataSource>(
      () => _i120.UserStatusRemoteDataSourceImpl(gh<_i374.SupabaseService>()),
    );
    gh.factory<_i528.GetAcceptedOrderMessagesRemoteDataSource>(
      () => _i567.GetAcceptedOrderMessagesRemoteDataSourceImpl(
        gh<_i374.SupabaseService>(),
      ),
    );
    gh.factory<_i223.GetPendingVerificationsUseCase>(
      () => _i223.GetPendingVerificationsUseCase(
        gh<_i256.PendingVerificationsRepo>(),
      ),
    );
    gh.factory<_i161.GetChatMessagesRemoteDataSource>(
      () => _i141.GetChatMessagesRemoteDataSourceImpl(
        gh<_i374.SupabaseService>(),
      ),
    );
    gh.factory<_i637.GetAdminConversionsRepo>(
      () => _i846.GetAdminConversionsRepoImpl(
        getConversationsRemoteDataSource:
            gh<_i159.GetAdminConversationsRemoteDataSource>(),
      ),
    );
    gh.factory<_i648.LateOrdersRemoteDataSource>(
      () => _i328.LateOrdersRemoteDataSourceImpl(gh<_i374.SupabaseService>()),
    );
    gh.factory<_i163.GetUserReviewsViewModel>(
      () => _i163.GetUserReviewsViewModel(gh<_i701.GetUserReviewsUseCase>()),
    );
    gh.factory<_i133.AddCommissionRemoteDataSource>(
      () =>
          _i573.AddCommissionRemoteDataSourceImpl(gh<_i374.SupabaseService>()),
    );
    gh.factory<_i580.GetAllReviewsViewModel>(
      () => _i580.GetAllReviewsViewModel(gh<_i44.GetAllReviewsUseCase>()),
    );
    gh.factory<_i5.GetUserInfoByIdRemoteDataSource>(
      () => _i131.GetUserInfoByIdRemoteDataSourceImpl(
        gh<_i374.SupabaseService>(),
      ),
    );
    gh.factory<_i358.LateOrdersRepo>(
      () => _i469.LateOrdersRepoImpl(gh<_i648.LateOrdersRemoteDataSource>()),
    );
    gh.factory<_i985.SubscribeToOrdersRemoteDataSource>(
      () => _i130.SubscribeToOrdersRemoteDataSourceImpl(
        gh<_i374.SupabaseService>(),
      ),
    );
    gh.factory<_i575.UpdateUserStatusRemoteDataSource>(
      () => _i362.UpdateUserStatusRemoteDataSourceImpl(
        gh<_i374.SupabaseService>(),
      ),
    );
    gh.factory<_i401.PaymentsUserRemoteDataSource>(
      () => _i558.PaymentsUserRemoteDataSourceImpl(gh<_i374.SupabaseService>()),
    );
    gh.factory<_i28.PaymentsRealtimeRemoteDataSource>(
      () => _i779.PaymentsRealtimeRemoteDataSourceImpl(
        gh<_i374.SupabaseService>(),
      ),
    );
    gh.factory<_i347.SubscribeToOffersRemoteDataSource>(
      () => _i1057.SubscribeToOffersRemoteDataSourceImpl(
        gh<_i374.SupabaseService>(),
      ),
    );
    gh.factory<_i343.OrdersRepos>(
      () => _i163.OrdersReposImpl(
        gh<_i985.SubscribeToOrdersRemoteDataSource>(),
        gh<_i5.GetUserInfoByIdRemoteDataSource>(),
        gh<_i347.SubscribeToOffersRemoteDataSource>(),
      ),
    );
    gh.factory<_i345.AttachmentsRepository>(
      () => _i727.AttachmentsRepositoryImpl(
        gh<_i1020.AttachmentsRemoteDataSource>(),
      ),
    );
    gh.factory<_i901.SendMessageRemoteDataSource>(
      () => _i540.SendMessageRemoteDataSourceImpl(gh<_i374.SupabaseService>()),
    );
    gh.factory<_i39.CategoryDistributionRemoteDataSource>(
      () => _i952.CategoryDistributionRemoteDataSourceImpl(
        supabaseService: gh<_i374.SupabaseService>(),
      ),
    );
    gh.factory<_i183.GetOrdersConversionsRepo>(
      () => _i902.GetOrdersConversionsRepoImpl(
        gh<_i7.GetOrdersConversionsRemoteDataSource>(),
      ),
    );
    gh.factory<_i499.DashboardRepos>(
      () => _i823.DashboardReposImpl(
        gh<_i172.GetAllOrdersRemoteDataSource>(),
        gh<_i133.AddCommissionRemoteDataSource>(),
        gh<_i976.GetAllUsersRemoteDataSource>(),
        gh<_i669.GetOrderByIdRemoteDataSource>(),
      ),
    );
    gh.factory<_i369.SendMessagesRepo>(
      () => _i192.SendMessagesRepoImpl(gh<_i901.SendMessageRemoteDataSource>()),
    );
    gh.factory<_i1069.BankAccountsRepository>(
      () =>
          _i739.AccountsBankReposImpl(gh<_i14.BankAccountsRemoteDataSource>()),
    );
    gh.factory<_i688.PendingPaymentsRepo>(
      () => _i77.PendingPaymentsRepoImpl(
        gh<_i589.PendingPaymentsRemoteDataSource>(),
      ),
    );
    gh.factory<_i970.GetUserInfoByIdUseCase>(
      () => _i970.GetUserInfoByIdUseCase(gh<_i343.OrdersRepos>()),
    );
    gh.factory<_i298.SubscribeToOffersUseCase>(
      () => _i298.SubscribeToOffersUseCase(gh<_i343.OrdersRepos>()),
    );
    gh.factory<_i286.SubscribeToOrdersUseCase>(
      () => _i286.SubscribeToOrdersUseCase(gh<_i343.OrdersRepos>()),
    );
    gh.factory<_i92.MarkMessageAsReadRepo>(
      () => _i969.MarkMessageAsReadRepoImpl(
        gh<_i107.MarkMessagesAsReadRemoteDataSource>(),
      ),
    );
    gh.factory<_i304.DeleteMessageRepo>(
      () => _i474.DeleteMessageRepoImpl(
        gh<_i295.DeleteMessageRemoteDataSource>(),
      ),
    );
    gh.factory<_i222.GetLateOrdersUseCase>(
      () => _i222.GetLateOrdersUseCase(gh<_i358.LateOrdersRepo>()),
    );
    gh.factory<_i416.DeleteAttachmentsUseCase>(
      () => _i416.DeleteAttachmentsUseCase(
        attachmentsRepository: gh<_i345.AttachmentsRepository>(),
      ),
    );
    gh.factory<_i231.UploadAttachmentsUseCase>(
      () => _i231.UploadAttachmentsUseCase(
        attachmentsRepository: gh<_i345.AttachmentsRepository>(),
      ),
    );
    gh.factory<_i122.GetAllOrdersUseCase>(
      () =>
          _i122.GetAllOrdersUseCase(dashboardRepos: gh<_i499.DashboardRepos>()),
    );
    gh.factory<_i199.GetAllUsersUseCase>(
      () =>
          _i199.GetAllUsersUseCase(dashboardRepos: gh<_i499.DashboardRepos>()),
    );
    gh.factory<_i197.DownloadAttachmentsUseCase>(
      () => _i197.DownloadAttachmentsUseCase(gh<_i345.AttachmentsRepository>()),
    );
    gh.factory<_i572.GetAllUsersViewModel>(
      () => _i572.GetAllUsersViewModel(gh<_i199.GetAllUsersUseCase>()),
    );
    gh.lazySingleton<_i892.DeleteMessageUseCase>(
      () => _i892.DeleteMessageUseCase(gh<_i304.DeleteMessageRepo>()),
    );
    gh.factory<_i14.UserStatusRepo>(
      () => _i790.UserStatusRepoImpl(gh<_i746.UserStatusRemoteDataSource>()),
    );
    gh.factory<_i625.SubscribeToMessagesRepo>(
      () => _i24.SubscribeToMessagesRepoImpl(
        gh<_i499.SubscribeToMessagesRemoteDataSource>(),
      ),
    );
    gh.factory<_i492.PaymentsRepository>(
      () => _i116.PaymentsReposImpl(
        gh<_i278.PaymentsAdminRemoteDataSource>(),
        gh<_i401.PaymentsUserRemoteDataSource>(),
        gh<_i557.UpdatePaymentStatusRemoteDataSource>(),
        gh<_i28.PaymentsRealtimeRemoteDataSource>(),
      ),
    );
    gh.factory<_i745.AuthViewModel>(
      () => _i745.AuthViewModel(authUseCase: gh<_i630.AuthUseCase>()),
    );
    gh.factory<_i737.GetAllOrdersViewModel>(
      () => _i737.GetAllOrdersViewModel(gh<_i122.GetAllOrdersUseCase>()),
    );
    gh.lazySingleton<_i621.SendMessageUseCase>(
      () => _i621.SendMessageUseCase(gh<_i369.SendMessagesRepo>()),
    );
    gh.factory<_i683.CategoryDistributionRepo>(
      () => _i405.CategoryDistributionRepoImpl(
        categoryDistributionRemoteDataSource:
            gh<_i39.CategoryDistributionRemoteDataSource>(),
      ),
    );
    gh.factory<_i948.SubscribeToOffersViewModel>(
      () => _i948.SubscribeToOffersViewModel(
        gh<_i298.SubscribeToOffersUseCase>(),
      ),
    );
    gh.factory<_i615.PendingVerificationsViewModel>(
      () => _i615.PendingVerificationsViewModel(
        gh<_i223.GetPendingVerificationsUseCase>(),
      ),
    );
    gh.factory<_i585.ProfileUseCase>(
      () => _i585.ProfileUseCase(gh<_i821.ProfileRepo>()),
    );
    gh.factory<_i420.LateOrdersViewModel>(
      () => _i420.LateOrdersViewModel(gh<_i222.GetLateOrdersUseCase>()),
    );
    gh.factory<_i799.UpdateOrderStatusRepo>(
      () => _i265.UpdateOrderStatusRepoImpl(
        gh<_i992.UpdateOrderStatusRemoteDataSource>(),
      ),
    );
    gh.factory<_i884.GetUserInfoByIdViewModel>(
      () => _i884.GetUserInfoByIdViewModel(gh<_i970.GetUserInfoByIdUseCase>()),
    );
    gh.factory<_i888.GetAllOrderMessagesRepo>(
      () => _i707.GetAllOrderMessagesRepoImpl(
        gh<_i528.GetAcceptedOrderMessagesRemoteDataSource>(),
      ),
    );
    gh.factory<_i881.GetConversationsUseCase>(
      () => _i881.GetConversationsUseCase(gh<_i637.GetAdminConversionsRepo>()),
    );
    gh.factory<_i1048.UpdatePaymentStatusUseCase>(
      () => _i1048.UpdatePaymentStatusUseCase(gh<_i492.PaymentsRepository>()),
    );
    gh.factory<_i338.DownloadAttachmentsViewModel>(
      () => _i338.DownloadAttachmentsViewModel(
        gh<_i197.DownloadAttachmentsUseCase>(),
      ),
    );
    gh.factory<_i40.AddCommissionUseCase>(
      () => _i40.AddCommissionUseCase(gh<_i499.DashboardRepos>()),
    );
    gh.factory<_i168.UsersRepos>(
      () => _i840.UsersReposImpl(
        gh<_i669.GetOrderByIdRemoteDataSource>(),
        gh<_i575.UpdateUserStatusRemoteDataSource>(),
      ),
    );
    gh.factory<_i862.UserStatusUseCase>(
      () => _i862.UserStatusUseCase(userStatusRepo: gh<_i14.UserStatusRepo>()),
    );
    gh.factory<_i641.GetMessagesRepo>(
      () => _i364.GetMessagesRepoImpl(
        gh<_i161.GetChatMessagesRemoteDataSource>(),
      ),
    );
    gh.factory<_i472.GetOrdersConversionsUseCase>(
      () => _i472.GetOrdersConversionsUseCase(
        gh<_i183.GetOrdersConversionsRepo>(),
      ),
    );
    gh.factory<_i11.UploadAttachmentsViewModel>(
      () =>
          _i11.UploadAttachmentsViewModel(gh<_i231.UploadAttachmentsUseCase>()),
    );
    gh.factory<_i287.OrdersByUserUseCase>(
      () => _i287.OrdersByUserUseCase(gh<_i168.UsersRepos>()),
    );
    gh.factory<_i842.UpdateUserStatusUseCase>(
      () => _i842.UpdateUserStatusUseCase(gh<_i168.UsersRepos>()),
    );
    gh.factory<_i380.SubscribeToOrdersViewModel>(
      () => _i380.SubscribeToOrdersViewModel(
        gh<_i286.SubscribeToOrdersUseCase>(),
      ),
    );
    gh.factory<_i648.GetAllPaymentsUseCase>(
      () => _i648.GetAllPaymentsUseCase(gh<_i492.PaymentsRepository>()),
    );
    gh.factory<_i579.GetUserPaymentsUseCase>(
      () => _i579.GetUserPaymentsUseCase(gh<_i492.PaymentsRepository>()),
    );
    gh.factory<_i547.SubscribePaymentsUseCase>(
      () => _i547.SubscribePaymentsUseCase(gh<_i492.PaymentsRepository>()),
    );
    gh.factory<_i784.GetPendingPaymentsUseCase>(
      () => _i784.GetPendingPaymentsUseCase(gh<_i688.PendingPaymentsRepo>()),
    );
    gh.factory<_i808.AddBankAccountUseCase>(
      () => _i808.AddBankAccountUseCase(gh<_i1069.BankAccountsRepository>()),
    );
    gh.factory<_i635.DeleteBankAccountUseCase>(
      () => _i635.DeleteBankAccountUseCase(gh<_i1069.BankAccountsRepository>()),
    );
    gh.factory<_i999.GetBankAccountsUseCase>(
      () => _i999.GetBankAccountsUseCase(gh<_i1069.BankAccountsRepository>()),
    );
    gh.factory<_i349.UpdateBankAccountStatusUseCase>(
      () => _i349.UpdateBankAccountStatusUseCase(
        gh<_i1069.BankAccountsRepository>(),
      ),
    );
    gh.factory<_i165.UpdateBankAccountUseCase>(
      () => _i165.UpdateBankAccountUseCase(gh<_i1069.BankAccountsRepository>()),
    );
    gh.factory<_i1055.GetAcceptedOrderMessagesUseCase>(
      () => _i1055.GetAcceptedOrderMessagesUseCase(
        gh<_i888.GetAllOrderMessagesRepo>(),
      ),
    );
    gh.lazySingleton<_i869.MarkMessagesAsReadUseCase>(
      () => _i869.MarkMessagesAsReadUseCase(gh<_i92.MarkMessageAsReadRepo>()),
    );
    gh.factory<_i252.UserStatusViewModel>(
      () => _i252.UserStatusViewModel(gh<_i862.UserStatusUseCase>()),
    );
    gh.factory<_i1055.UserPaymentsViewModel>(
      () => _i1055.UserPaymentsViewModel(gh<_i579.GetUserPaymentsUseCase>()),
    );
    gh.factory<_i535.DeleteBankAccountViewModel>(
      () => _i535.DeleteBankAccountViewModel(
        gh<_i635.DeleteBankAccountUseCase>(),
      ),
    );
    gh.factory<_i660.CategoryDistributionUseCase>(
      () => _i660.CategoryDistributionUseCase(
        categoryDistributionRepo: gh<_i683.CategoryDistributionRepo>(),
      ),
    );
    gh.factory<_i215.AddCommissionViewModel>(
      () => _i215.AddCommissionViewModel(gh<_i40.AddCommissionUseCase>()),
    );
    gh.factory<_i263.GetOrderMessagesUseCase>(
      () => _i263.GetOrderMessagesUseCase(
        gh<_i641.GetMessagesRepo>(),
        gh<_i625.SubscribeToMessagesRepo>(),
      ),
    );
    gh.factory<_i1003.ProfileViewModel>(
      () => _i1003.ProfileViewModel(gh<_i585.ProfileUseCase>()),
    );
    gh.factory<_i579.PendingPaymentsViewModel>(
      () =>
          _i579.PendingPaymentsViewModel(gh<_i784.GetPendingPaymentsUseCase>()),
    );
    gh.factory<_i195.DeleteAttachmentsViewModel>(
      () => _i195.DeleteAttachmentsViewModel(
        gh<_i416.DeleteAttachmentsUseCase>(),
      ),
    );
    gh.factory<_i496.UpdatePaymentStatusViewModel>(
      () => _i496.UpdatePaymentStatusViewModel(
        gh<_i1048.UpdatePaymentStatusUseCase>(),
      ),
    );
    gh.factory<_i597.SendMessageViewModel>(
      () => _i597.SendMessageViewModel(gh<_i621.SendMessageUseCase>()),
    );
    gh.factory<_i190.AdminPaymentsViewModel>(
      () => _i190.AdminPaymentsViewModel(gh<_i648.GetAllPaymentsUseCase>()),
    );
    gh.factory<_i601.UpdateOrderStatusUseCase>(
      () => _i601.UpdateOrderStatusUseCase(gh<_i799.UpdateOrderStatusRepo>()),
    );
    gh.factory<_i612.UpdateBankAccountStatusViewModel>(
      () => _i612.UpdateBankAccountStatusViewModel(
        gh<_i349.UpdateBankAccountStatusUseCase>(),
      ),
    );
    gh.factory<_i370.PaymentsViewModel>(
      () => _i370.PaymentsViewModel(
        gh<_i648.GetAllPaymentsUseCase>(),
        gh<_i547.SubscribePaymentsUseCase>(),
      ),
    );
    gh.factory<_i888.CategoryDistributionViewModel>(
      () => _i888.CategoryDistributionViewModel(
        gh<_i660.CategoryDistributionUseCase>(),
      ),
    );
    gh.factory<_i56.GetConversationsViewModel>(
      () => _i56.GetConversationsViewModel(gh<_i881.GetConversationsUseCase>()),
    );
    gh.factory<_i1066.UpdateUserStatusViewModel>(
      () =>
          _i1066.UpdateUserStatusViewModel(gh<_i842.UpdateUserStatusUseCase>()),
    );
    gh.factory<_i258.UpdateBankAccountViewModel>(
      () => _i258.UpdateBankAccountViewModel(
        gh<_i165.UpdateBankAccountUseCase>(),
      ),
    );
    gh.factory<_i613.GetOrdersByIdViewModel>(
      () => _i613.GetOrdersByIdViewModel(gh<_i287.OrdersByUserUseCase>()),
    );
    gh.factory<_i996.GetOrdersConversionsViewModel>(
      () => _i996.GetOrdersConversionsViewModel(
        gh<_i472.GetOrdersConversionsUseCase>(),
      ),
    );
    gh.factory<_i295.UpdateOrderStatusViewModel>(
      () => _i295.UpdateOrderStatusViewModel(
        gh<_i601.UpdateOrderStatusUseCase>(),
      ),
    );
    gh.factory<_i934.SubscribePaymentsViewModel>(
      () => _i934.SubscribePaymentsViewModel(
        gh<_i547.SubscribePaymentsUseCase>(),
      ),
    );
    gh.factory<_i63.GetMessagesViewModel>(
      () => _i63.GetMessagesViewModel(gh<_i263.GetOrderMessagesUseCase>()),
    );
    gh.factory<_i79.GetBankAccountViewModel>(
      () => _i79.GetBankAccountViewModel(gh<_i999.GetBankAccountsUseCase>()),
    );
    gh.factory<_i1047.GetAcceptedOrderMessageViewModel>(
      () => _i1047.GetAcceptedOrderMessageViewModel(
        gh<_i1055.GetAcceptedOrderMessagesUseCase>(),
      ),
    );
    gh.factory<_i634.AddBankAccountViewModel>(
      () => _i634.AddBankAccountViewModel(gh<_i808.AddBankAccountUseCase>()),
    );
    return this;
  }
}
