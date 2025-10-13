// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Taskly';

  @override
  String get client => 'Client';

  @override
  String get freelancer => 'Freelancer';

  @override
  String get sar => 'SAR';

  @override
  String get welcomeMessage => 'Organize work, connect,\n and succeed!';

  @override
  String get freelancerTitle => 'I\'m a Freelancer';

  @override
  String get freelancerSubtitle => 'Find projects & grow your career';

  @override
  String get clientTitle => 'I\'m a Client';

  @override
  String get clientSubtitle => 'Hire talents to get your work done';

  @override
  String get createFreelancerAccount => 'Create Freelancer Account';

  @override
  String get createClientAccount => 'Create Client Account';

  @override
  String get alreadyHaveAccount => 'Already have an account?';

  @override
  String get login => 'Log in';

  @override
  String get registerFreelancerSubtitle => 'Sign up to find work';

  @override
  String get registerClientSubtitle => 'Sign up to hire the best talent';

  @override
  String get firstName => 'First Name';

  @override
  String get lastName => 'Last Name';

  @override
  String get email => 'Email';

  @override
  String get password => 'Password';

  @override
  String get createAccount => 'Create my account';

  @override
  String get thisFieldIsRequired => 'This field is required';

  @override
  String get welcomeBack => 'Welcome back';

  @override
  String get dontHaveAccount => 'Don\'t have an account?';

  @override
  String get signUp => 'Sign up';

  @override
  String get continueWithGoogle => 'Continue with Google';

  @override
  String get privacyPolicyAgreement => 'By creating an account you agree to the ';

  @override
  String get privacyPolicy => 'privacy policy';

  @override
  String get termsAgreement => ' and to the ';

  @override
  String get termsOfUse => 'terms of use';

  @override
  String get or => 'Or';

  @override
  String get noInternetConnection => 'No internet connection';

  @override
  String get emailAlreadyExists => 'Email already exists or not confirmed. Please check your email.';

  @override
  String get somethingWentWrong => 'Something went wrong, please try again';

  @override
  String get loginFailed => 'Login failed. Please check your email and password.';

  @override
  String notRegisteredAsRole(Object role) {
    return 'You are not registered as $role. Please use the correct account.';
  }

  @override
  String get googleLoginCancelled => 'Google login cancelled';

  @override
  String accountAlreadyRegistered(Object existingRole, Object role) {
    return 'This account is already registered as $existingRole. You cannot register as $role.';
  }

  @override
  String get userRegisteredSuccessfully => 'User registered successfully';

  @override
  String get userLoginSuccessfully => 'User Login successfully';

  @override
  String get googleLoginSuccessful => 'Google login successful';

  @override
  String get dashboardDescription => 'Manage all freelancers and clients in one dashboard';

  @override
  String get performanceTracking => 'Track orders, monitor performance, and keep everything under control';

  @override
  String get skip => 'Skip';

  @override
  String get letsGo => 'Let\'s Go';

  @override
  String get dashboard => 'Dashboard';

  @override
  String get users => 'Users';

  @override
  String get orders => 'Orders';

  @override
  String get payments => 'Payments';

  @override
  String hiUser(Object name) {
    return 'Hi $name,';
  }

  @override
  String get welcomeTaskly => 'Welcome to Taskly';

  @override
  String get revenueTrend => 'Revenue Trend';

  @override
  String get totalRevenueInfo => 'Total revenue growth over time';

  @override
  String get orderVolume => 'Order Volume';

  @override
  String get dailyOrderInfo => 'Daily order completion rate';

  @override
  String get categoryDistribution => 'Category Distribution';

  @override
  String get serviceCategoryInfo => 'Service categories by revenue share';

  @override
  String errorPrefix(Object message) {
    return 'Error: $message';
  }

  @override
  String get dashboardOrders => 'Orders';

  @override
  String get dashboardEarnings => 'Earnings';

  @override
  String get dashboardClients => 'Clients';

  @override
  String get dashboardFreelancers => 'Freelancers';

  @override
  String get pendingVerifications => 'Pending Verifications';

  @override
  String get disputesNeedingReview => 'Disputes Needing Review';

  @override
  String get pendingPayments => 'Pending Payments';

  @override
  String get lateOrders => 'Late Orders';

  @override
  String get kpiTitle => 'Key Performance Indicators';

  @override
  String get trendsTitle => 'Visual Trends & Insights';

  @override
  String get monthlyView => 'Monthly View';

  @override
  String get pendingActionsTitle => 'Pending Action & Alerts';

  @override
  String get exportCSVTitle => 'Export Financial CSV';

  @override
  String get exportMoneyCSV => 'Export Money CSV';

  @override
  String get categoryAcademic => 'Academic';

  @override
  String get categoryReports => 'Reports';

  @override
  String get categoryMindMaps => 'Mind Maps';

  @override
  String get categoryTranslation => 'Translation';

  @override
  String get categorySummaries => 'Summaries';

  @override
  String get categoryProjects => 'Projects';

  @override
  String get categoryPresentations => 'Presentations';

  @override
  String get categorySPSS => 'SPSS';

  @override
  String get categoryProofreading => 'Proofreading';

  @override
  String get categoryCV => 'CV';

  @override
  String get categoryProgramming => 'Programming';

  @override
  String get categoryCourses => 'Courses';

  @override
  String get categoryConsulting => 'Consulting';

  @override
  String get categoryDesign => 'Design';

  @override
  String get categoryEngineering => 'Engineering';

  @override
  String get categoryFinance => 'Finance';

  @override
  String get legendAcademic => 'Academic Sources';

  @override
  String get legendReports => 'Scientific Reports';

  @override
  String get legendMindMaps => 'Mind Maps';

  @override
  String get legendTranslation => 'Languages & Translation';

  @override
  String get legendSummaries => 'Summaries';

  @override
  String get legendProjects => 'Scientific Projects';

  @override
  String get legendPresentations => 'Presentations';

  @override
  String get legendSPSS => 'SPSS Analysis';

  @override
  String get legendProofreading => 'Proofreading';

  @override
  String get legendCV => 'CV / Resume';

  @override
  String get legendProgramming => 'Programming & Web Design';

  @override
  String get legendCourses => 'Courses & Tutorials';

  @override
  String get legendConsulting => 'Specialized Consulting';

  @override
  String get legendDesign => 'Graphic Design';

  @override
  String get legendEngineering => 'Engineering Services';

  @override
  String get legendFinance => 'Financial & Accounting';

  @override
  String get manageDashboard => 'Manage Dashboard';

  @override
  String get manageUsers => 'Manage Users';

  @override
  String get searchByName => 'Search by name';

  @override
  String get searchByEmail => 'Search by email';

  @override
  String get clients => 'Clients';

  @override
  String get freelancers => 'Freelancers';

  @override
  String get totalOrders => 'Total Orders';

  @override
  String get completed => 'Completed';

  @override
  String get earnings => 'Earnings';

  @override
  String get rating => 'Rating';

  @override
  String get keyPerformanceIndicators => 'Key Performance Indicators';

  @override
  String get visualTrendsInsights => 'Visual Trends & Insights';

  @override
  String get pendingActionAlerts => 'Pending Action & Alerts';

  @override
  String get exportFinancialCSV => 'Export Financial CSV';

  @override
  String get academic => 'Academic';

  @override
  String get reports => 'Reports';

  @override
  String get mindMaps => 'Mind Maps';

  @override
  String get translation => 'Translation';

  @override
  String get summaries => 'Summaries';

  @override
  String get projects => 'Projects';

  @override
  String get presentations => 'Presentations';

  @override
  String get spss => 'SPSS';

  @override
  String get proofreading => 'Proofreading';

  @override
  String get cv => 'CV';

  @override
  String get programming => 'Programming';

  @override
  String get courses => 'Courses';

  @override
  String get consulting => 'Consulting';

  @override
  String get design => 'Design';

  @override
  String get engineering => 'Engineering';

  @override
  String get finance => 'Finance';

  @override
  String get academicSources => 'Academic Sources';

  @override
  String get scientificReports => 'Scientific Reports';

  @override
  String get languagesTranslation => 'Languages & Translation';

  @override
  String get scientificProjects => 'Scientific Projects';

  @override
  String get spssAnalysis => 'SPSS Analysis';

  @override
  String get cvResume => 'CV / Resume';

  @override
  String get programmingWebDesign => 'Programming & Web Design';

  @override
  String get coursesTutorials => 'Courses & Tutorials';

  @override
  String get specializedConsulting => 'Specialized Consulting';

  @override
  String get graphicDesign => 'Graphic Design';

  @override
  String get engineeringServices => 'Engineering Services';

  @override
  String get financialAccounting => 'Financial & Accounting';

  @override
  String get clearAll => 'Clear All';

  @override
  String get status => 'Status';

  @override
  String get sortedBy => 'Sorted By';

  @override
  String get apply => 'Apply';

  @override
  String get highestRating => 'Highest Rating';

  @override
  String get mostEarnings => 'Most Earnings';

  @override
  String get mostCompleted => 'Most Completed';

  @override
  String get newest => 'Newest';

  @override
  String get oldest => 'Oldest';

  @override
  String get active => 'Active';

  @override
  String get suspended => 'Suspended';

  @override
  String get inactive => 'Inactive';

  @override
  String get all => 'All';

  @override
  String get filters => 'Filters';

  @override
  String get pending => 'Pending';

  @override
  String get verifiedFreelancer => 'Verified Freelancer';

  @override
  String get userDetails => 'User Details';

  @override
  String get phone => 'Phone:';

  @override
  String get registrationDate => 'Registration Date:';

  @override
  String get lastUpdated => 'Last Updated:';

  @override
  String get adminActions => 'Admin Actions';

  @override
  String get activeDeactivate => 'Active/Deactivate';

  @override
  String get sendMessage => 'Send Message';

  @override
  String get verify => 'Verify';

  @override
  String get unverify => 'Unverify';

  @override
  String get activityStatistics => 'Activity Statistics';

  @override
  String get noOrdersYet => 'No Orders Yet';

  @override
  String get filtersTooltip => 'Filters';

  @override
  String get notAvailable => 'Not Available';

  @override
  String get unassigned => 'Unassigned';

  @override
  String get jobs => 'jobs';

  @override
  String get reviews => 'Reviews';

  @override
  String get orderDetails => 'Order Details';

  @override
  String get manageOrders => 'Manage Orders';

  @override
  String get searchForOrder => 'Search for order';

  @override
  String get searchByStatus => 'Search by status';

  @override
  String get searchByClientName => 'Search by client name';

  @override
  String get delayed => 'Delayed';

  @override
  String get newOrder => 'New';

  @override
  String get progress => 'Progress';

  @override
  String get delivered => 'Delivered';

  @override
  String get cancelled => 'Cancelled';

  @override
  String get noOrdersHere => 'No orders here';

  @override
  String get late => 'Late';

  @override
  String get viewDetails => 'View Details';

  @override
  String get loadingUserInfo => 'Loading client & freelancer info...';

  @override
  String get clientDetails => 'Client Details';

  @override
  String get freelancerDetails => 'Freelancer Details';

  @override
  String get requestId => 'Request ID';

  @override
  String get offerId => 'Offer ID';

  @override
  String get orderTimeline => 'Order Timeline';

  @override
  String get cancelOrder => 'Cancel Order';

  @override
  String get orderCreated => 'Order Created';

  @override
  String get paymentConfirmed => 'Payment Confirmed';

  @override
  String get workStarted => 'Work Started';

  @override
  String get delivery => 'Delivery';

  @override
  String get deadlineExpired => 'Deadline Expired';

  @override
  String get noCategory => 'No Category';

  @override
  String get offers => 'Offers';

  @override
  String get filterBy => 'Filter by:';

  @override
  String get price => 'Price';

  @override
  String get offersReceived => 'Offers Received';

  @override
  String get posted => 'Posted';

  @override
  String get description => 'Description';

  @override
  String get noDescription => 'No Description';

  @override
  String get created => 'Created';

  @override
  String get paid => 'Paid';

  @override
  String get inProgress => 'In Progress';

  @override
  String get accepted => 'Accepted';

  @override
  String get paidPending => 'Paid (Pending Confirmation)';

  @override
  String get deadline => 'Deadline';

  @override
  String get rejected => 'Rejected';

  @override
  String get id => 'ID';

  @override
  String get attachments => 'Attachments';

  @override
  String get serviceType => 'Service Type';

  @override
  String get budget => 'Budget';

  @override
  String get createdAt => 'Created At';

  @override
  String get updatedAt => 'Updated At';

  @override
  String get offersCount => 'Offers Count';

  @override
  String get theme => 'Theme';

  @override
  String get dark => 'Dark';

  @override
  String get light => 'Light';

  @override
  String get language => 'Language';

  @override
  String get close => 'Close';

  @override
  String get commissionPercentage => 'Commission Percentage';

  @override
  String get save => 'Save';

  @override
  String get noReviews => 'No Reviews';

  @override
  String get noReviewsHere => 'No reviews here';

  @override
  String get noReviewsForThisFreelancer => 'No reviews for this freelancer';

  @override
  String get noReviewsForThisClient => 'No reviews for this client';

  @override
  String get reviewsGiven => 'Reviews Given';

  @override
  String get reviewsReceived => 'Reviews Received';

  @override
  String get noReviewsGiven => 'No reviews given';

  @override
  String get noReviewsReceived => 'No reviews received';

  @override
  String get noReviewsGivenForThisClient => 'No reviews given for this client';

  @override
  String get noReviewsGivenForThisFreelancer => 'No reviews given for this freelancer';

  @override
  String get noReviewsReceivedForThisClient => 'No reviews received for this client';

  @override
  String get service1 => 'Providing academic sources and references';

  @override
  String get service2 => 'Scientific reports';

  @override
  String get service3 => 'Mind maps';

  @override
  String get service4 => 'Languages and translation';

  @override
  String get service5 => 'Summarizing books, articles, and lectures';

  @override
  String get service6 => 'Scientific projects';

  @override
  String get service7 => 'Presentations (PowerPoint)';

  @override
  String get service8 => 'Statistical analysis (SPSS)';

  @override
  String get service9 => 'Proofreading';

  @override
  String get service10 => 'Resume/CV';

  @override
  String get service11 => 'Programming and web design';

  @override
  String get service12 => 'Tutorials and courses';

  @override
  String get service13 => 'Specialized consultations by field';

  @override
  String get service14 => 'Graphic design 🎨';

  @override
  String get service15 => 'Engineering services';

  @override
  String get service16 => 'Financial and accounting services';

  @override
  String get orderNow => 'Order Now';

  @override
  String get noServicesFound => 'No services found';

  @override
  String get forgotPassword => 'Forgot Password?';

  @override
  String get continuewithface => 'Continue with Facebook';

  @override
  String get continuewithapple => 'Continue with Apple';

  @override
  String get welcome_to_taskly => 'Welcome To Taskly';

  @override
  String get search_for_services => 'Search for services';

  @override
  String get order_created_success => 'Order created successfully';

  @override
  String get something_went_wrong => 'Something went wrong, try again later';

  @override
  String get title_label => 'Title';

  @override
  String get category_label => 'Category';

  @override
  String get description_label => 'Description';

  @override
  String get deadline_label => 'Deadline';

  @override
  String get attachments_label => 'Attachments';

  @override
  String get hiring_method_label => 'Hiring Method';

  @override
  String get submit_button => 'Submit';

  @override
  String get error_enter_title => 'Please enter title';

  @override
  String get error_choose_category => 'Please choose category';

  @override
  String get error_enter_description => 'Please enter description';

  @override
  String get error_enter_deadline => 'Please enter deadline';

  @override
  String get error_add_attachments => 'Please add attachments';

  @override
  String get error_select_hiring_method => 'Please select hiring method';

  @override
  String get error_wait_attachments => 'Please wait until all attachments are uploaded';

  @override
  String get error_select_freelancer => 'Please select freelancer';

  @override
  String get description_hint => 'Write your description here';

  @override
  String get enter_time => 'Enter time';

  @override
  String get uploading => 'Uploading...';

  @override
  String get uploaded_successfully => 'Uploaded Successfully ✅';

  @override
  String get no_files_uploaded_yet => 'No files uploaded yet';

  @override
  String files_uploaded_count(Object count) {
    return '$count files uploaded';
  }

  @override
  String get file_not_found_for_deletion => 'File not found for deletion';

  @override
  String get failed_to_delete_file => 'Failed to delete file';

  @override
  String get file_deleted_successfully => 'File deleted successfully';

  @override
  String error(Object error) {
    return 'Error: $error';
  }

  @override
  String get public_posting_title => 'Public Posting';

  @override
  String get public_posting_subtitle => 'Post your request publicly and receive multiple proposals';

  @override
  String get hire_specific_freelancer_title => 'Hire Specific Freelancer';

  @override
  String get hire_specific_freelancer_subtitle => 'Send your request directly to a specific freelancer as a private offer';

  @override
  String get private_badge => 'Private';

  @override
  String get search_freelancers_hint => 'Search freelancers by name...';

  @override
  String get choose_best_match_hint => 'Choose the best match for your project';

  @override
  String get service_order => 'Service Order';

  @override
  String get statistical_analysis => 'Statistical Analysis';

  @override
  String get resume => 'Resume';

  @override
  String get tutorials => 'Tutorials';

  @override
  String get consultations => 'Consultations';

  @override
  String get graphic_design => 'Graphic Design';

  @override
  String get engineering_services => 'Engineering Services';

  @override
  String get financial_services => 'Financial Services';

  @override
  String get other => 'Other';

  @override
  String get no_pending_orders_yet => 'No pending orders yet';

  @override
  String get no_orders_in_progress => 'No orders in progress';

  @override
  String get no_completed_orders => 'No completed orders';

  @override
  String get no_cancelled_orders => 'No cancelled orders';

  @override
  String get unverified_freelancer => 'Unverified Freelancer';

  @override
  String get payment_under_review => 'Payment under review';

  @override
  String paid_now(Object amount) {
    return 'Paid Now $amount SAR';
  }

  @override
  String get confirm_delete => 'Confirm Delete';

  @override
  String get delete_confirmation_message => 'Are you sure you want to delete this order?';

  @override
  String get delete => 'Delete';

  @override
  String get no_offers_yet => 'No offers yet';

  @override
  String get offer_accepted_successfully => 'Offer accepted successfully';

  @override
  String get offer_rejected_successfully => 'Offer rejected successfully';

  @override
  String get error_temp => 'Error';

  @override
  String get loading => 'Loading...';

  @override
  String get decline_offer => 'Decline Offer';

  @override
  String get accept_offer => 'Accept Offer';

  @override
  String get start_chat => 'Start Chat';

  @override
  String get view_less => 'View Less';

  @override
  String get view_more => 'View More';

  @override
  String get waiting => 'Waiting';

  @override
  String get file_viewer => 'File Viewer';

  @override
  String get warning => 'Warning';

  @override
  String get upload_warning_message => 'You have uploaded payment proof but haven\'t pressed Make Payment. Are you sure you want to leave?';

  @override
  String get stay => 'Stay';

  @override
  String get leave => 'Leave';

  @override
  String get upload_payment_proof => 'Upload Payment Proof';

  @override
  String get secure_payment_note => '🔒 Secure payment. Funds will not be released until the work is completed.';

  @override
  String get payment_under_review_message => '📢 Don\'t worry, your payment request is under review.\nIt usually doesn\'t take long.';

  @override
  String get payment_status => 'Payment Status';

  @override
  String get awaiting_approval => 'Awaiting approval';

  @override
  String amount_sar(Object amount) {
    return 'Amount: $amount SAR';
  }

  @override
  String get contact_us_note => '📣 If you have any questions, please contact us. We are here to help!';

  @override
  String get chat_with_admin => 'Chat with Admin Now';

  @override
  String get upload_note => 'Note: After completing the transfer, please upload a photo of the receipt or a screenshot from your banking app as proof of payment.';

  @override
  String get leave_warning_message => 'You have uploaded payment proof but haven\'t pressed Make Payment. Are you sure you want to leave?';

  @override
  String get creating_payment => 'Creating payment...';

  @override
  String get payment_created_success => 'Payment created successfully, please wait for admin approval';

  @override
  String get make_payment => 'Make Payment';

  @override
  String get please_upload_proof => 'Please upload payment proof';

  @override
  String get please_wait_uploads => 'Please wait until all attachments are uploaded';

  @override
  String get iban_number => 'IBAN Number';

  @override
  String get account_number => 'Account Number';

  @override
  String get account_name => 'Account Name';

  @override
  String get swift_code => 'SWIFT Code';

  @override
  String get wait_uploads => 'Please wait until all attachments are uploaded';

  @override
  String get upload_payment_proof_first => 'Please upload payment proof';

  @override
  String get payment_proof_uploaded_success => 'Payment proof uploaded successfully';

  @override
  String get home => 'Home';

  @override
  String get find_work => 'Find Work';

  @override
  String get my_jobs => 'My Jobs';

  @override
  String get messages => 'Messages';

  @override
  String get profile => 'Profile';

  @override
  String get search_for_orders => 'Search for orders...';

  @override
  String get search_for_private_orders => 'Search for private orders...';

  @override
  String get search_for_public_orders => 'Search for public orders...';

  @override
  String get search_for_favorite_orders => 'Search for favorite orders...';

  @override
  String get public_requests => 'Public Requests';

  @override
  String get private_requests => 'Private Requests';

  @override
  String get account_under_verification => 'Your account is under verification.\nPlease wait until your request is approved.';

  @override
  String get send_offers => 'Send offers';

  @override
  String get send_offer => 'Send offer';

  @override
  String get week => 'Week';

  @override
  String get weeks => 'Weeks';

  @override
  String get day => 'Day';

  @override
  String get days => 'Days';

  @override
  String get hour => 'Hour';

  @override
  String get hours => 'Hours';

  @override
  String get minute => 'Minute';

  @override
  String get minutes => 'Minutes';

  @override
  String get just_now => 'just now';

  @override
  String minutes_ago(Object minutes) {
    return '$minutes minutes ago';
  }

  @override
  String get minute_ago => '1 minute ago';

  @override
  String hours_ago(Object hours) {
    return '$hours hours ago';
  }

  @override
  String get hour_ago => '1 hour ago';

  @override
  String days_ago(Object days) {
    return '$days days ago';
  }

  @override
  String get day_ago => '1 day ago';

  @override
  String get online => 'Online';

  @override
  String get last_seen_unknown => 'Last seen: Unknown';

  @override
  String last_seen_today(Object time) {
    return 'Last seen today at $time';
  }

  @override
  String last_seen_yesterday(Object time) {
    return 'Last seen yesterday at $time';
  }

  @override
  String last_seen_days_ago(Object days) {
    return 'Last seen $days days ago';
  }

  @override
  String last_seen_on_date(Object date) {
    return 'Last seen on $date';
  }

  @override
  String get time_suffix_ago => ' ago';

  @override
  String get time_suffix_left => ' left';

  @override
  String get time_day => 'day';

  @override
  String get time_days => 'days';

  @override
  String get time_hour => 'hour';

  @override
  String get time_hours => 'hours';

  @override
  String get time_minute => 'minute';

  @override
  String get time_minutes => 'minutes';

  @override
  String get unknown_client => 'Unknown Client';

  @override
  String jobs_posted(Object count) {
    return '$count jobs posted';
  }

  @override
  String get no_public_orders_available => 'No public orders available';

  @override
  String get no_private_orders_available => 'No private orders available';

  @override
  String get job_details => 'Job Details';

  @override
  String get about_this_job => 'About this job';

  @override
  String get project_duration => 'Project Duration';

  @override
  String get unknown => 'Unknown';

  @override
  String get withdraw_offer => 'Withdraw offer';

  @override
  String get withdrawing => 'Withdrawing...';

  @override
  String get proposal_description => 'Proposal description';

  @override
  String get delete_this_offer => 'Delete this offer';

  @override
  String get no_rejected_offers => 'No rejected offers';

  @override
  String get no_completed_projects_yet => 'No completed projects yet';

  @override
  String get no_accepted_offers => 'No accepted offers';

  @override
  String get no_pending_offers => 'No pending offers';

  @override
  String get send_offer_title => 'Send offer';

  @override
  String get project_details => 'Project Details :';

  @override
  String get proposal_price => 'Proposal Price :';

  @override
  String get enter_price_hint => 'Enter price';

  @override
  String get price_after_commission => 'Price after commission:';

  @override
  String get delivery_time => 'Delivery Time :';

  @override
  String get enter_time_hint => 'Enter time';

  @override
  String get offer_description_hint => 'Explain how you will execute this project, including methods or any specific conditions....';

  @override
  String get description_error => 'Please enter a description';

  @override
  String get price_error => 'Please enter a price';

  @override
  String get delivery_time_error => 'Please enter a delivery time';

  @override
  String get offer_sent_success => 'Offer sent successfully';

  @override
  String get exportOrdersCSVTitle => 'Export Orders CSV';

  @override
  String get noConversationsFound => 'No conversations found';

  @override
  String get orderId => 'Order ID';

  @override
  String get totalPrice => 'Total Price';

  @override
  String get bankAccountManagement => 'Bank Account Management';

  @override
  String get managePayments => 'Manage Payments';

  @override
  String get editBankAccount => 'Edit Bank Account';

  @override
  String get clientPayments => 'Client Payments';

  @override
  String get freelancerWithdrawals => 'Freelancer Withdrawals';

  @override
  String get paymentDetails => 'Payment Details';

  @override
  String get paymentID => 'Payment ID';

  @override
  String get freelancerID => 'Freelancer ID';

  @override
  String get paymentMethod => 'Payment Method';

  @override
  String get accountNumber => 'Account Number';

  @override
  String get freelancerInfo => 'Freelancer Info';

  @override
  String get balance => 'Balance';

  @override
  String get requestedWithdraw => 'Requested Withdraw';

  @override
  String get clientID => 'Client ID';

  @override
  String get addBankAccount => 'Add Bank Account';

  @override
  String get bankTransferReceipt => 'Bank Transfer Receipt';

  @override
  String get basicInformation => 'Basic Information';

  @override
  String get accountDetails => 'Account Details';

  @override
  String get additionalDetails => 'Additional Details';

  @override
  String get accountSettings => 'Account Settings';

  @override
  String get bankName => 'Bank Name';

  @override
  String get accountName => 'Account Name';

  @override
  String get iban => 'IBAN';

  @override
  String get swiftCode => 'SWIFT Code';

  @override
  String get notesOptional => 'Notes (Optional)';

  @override
  String get activeAccount => 'Active Account';

  @override
  String get enableOrDisableBankAccount => 'Enable or disable this bank account';

  @override
  String get update => 'Update';

  @override
  String get deleteAccount => 'Delete Account';

  @override
  String get bankAccountSavedSuccessfully => 'Bank account saved successfully ✅';

  @override
  String get bankAccountUpdatedSuccessfully => 'Bank account updated successfully ✅';

  @override
  String get bankAccountDeletedSuccessfully => 'Bank account deleted successfully ✅';

  @override
  String get noAccountsFound => 'No accounts found';

  @override
  String get deactivateAccount => 'Deactivate account';

  @override
  String get activateAccount => 'Activate account';

  @override
  String get edit => 'Edit';

  @override
  String get notes => 'Notes';

  @override
  String get searchPayments => 'Search payments';

  @override
  String get searchWithdrawals => 'Search withdrawals';

  @override
  String get searchBankAccount => 'Search bank account';

  @override
  String get welcomeAdmin => 'Welcome Admin now\nmanage your dashboard';
}
