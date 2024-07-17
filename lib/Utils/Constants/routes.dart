import '../../Models/Account%20Setup/Pages/register_page.dart';
import '../../Models/AllCources/Pages/all_courses_checkout_page.dart';
import '../../Models/AllCources/Pages/all_courses_page.dart';
import '../../Models/AllCources/Pages/all_courses_pages_details.dart';
import '../../Models/Category/Pages/category_details.dart';
import '../../Models/Favouties/Pages/favouties_page.dart';
import '../../Models/Financial/Pages/financial_page.dart';
import '../../Models/ForgetPassword/Pages/forgot_otp_password_scren.dart';
import '../../Models/ForgetPassword/Pages/forgot_password_page.dart';
import '../../Models/Home/Pages/see_all.dart';
import '../../Models/Login/Pages/login_page_gmail.dart';
import '../../Models/Login/Pages/login_page_phone.dart';
import '../../Models/Meeting/Pages/meeting_details_page.dart';
import '../../Models/Meeting/Pages/meeting_page.dart';
import '../../Models/Meeting/Pages/meeting_web_view.dart';
import '../../Models/Notification/Pages/notification_page.dart';
import '../../Models/Onboarding%20Screen/Pages/onboarding_screen.dart';
import '../../Models/Practice%20Question/Pages/practice_questions.dart';
import '../../Models/PreviousPapers/previous_paper_page.dart';
import '../../Models/QuizQuesandAns/Page/quizques_and_ans.dart';
import '../../Models/Quizes/Quiz%20Details/Pages/quiz_details_page_one.dart';
import '../../Models/Quizes/Quiz%20Details/Pages/quiz_details_page_two.dart';
import '../../Models/Reward%20Courses/Pages/rewards_page.dart';
import '../../Models/SearchPage/Page/search_page.dart';
import '../../Models/Signup/Pages/otp_verification_page.dart';
import '../../Models/Signup/Pages/signup_page.dart';
import '../../Models/SplashScreen/splash_screen.dart';
import '../../Models/Subscription/Pages/subscription_page.dart';
import '../../Models/Support/Page/chapter_details.dart';
import '../../Models/Your%20Library/your_library.dart';
import '../BottomNavigation/bottom_navigation.dart';
import 'package:get/get.dart';

import '../../Models/Blog/Pages/blog_page.dart';
import '../../Models/Blog/Pages/blog_post.dart';
import '../../Models/Meeting/Calender Widget/calender_widget.dart';
import '../../Models/Meeting/Calender Widget/event_editing_page.dart';
import '../../Models/Payment Success/payment_success_screen.dart';
import '../../Models/Video Section/video_section.dart';

class Routes {
  static List<GetPage<dynamic>>? pages = [
    GetPage(
      name: RoutesName.splashScreen,
      page: () => const Splashscreen(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(seconds: 2),
    ),
    GetPage(
      name: RoutesName.onboardingPages,
      page: () => const OnboardScreen(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(seconds: 2),
    ),
    GetPage(
        name: RoutesName.loginInPagePhone,
        page: () => const LoginInPagePhone()),
    GetPage(
        name: RoutesName.loginInPageEmail,
        page: () => const LoginInPageGmail()),
    GetPage(name: RoutesName.signUpPage, page: () => const SignUpPage()),
    GetPage(
      name: RoutesName.bottomNavigation,
      page: () => BottomNavigation(),
      transition: Transition.cupertino,
    ),
    GetPage(name: RoutesName.registerPage, page: () => const RegisterPage()),
    GetPage(
        name: RoutesName.otpVerificationPage,
        page: () => OtpVerificationPage()),
    GetPage(
      name: RoutesName.forgotPasswordOTPScreen,
      page: () => const ForgotPasswordOTPVerificationPage(),
    ),
    GetPage(
        name: RoutesName.allCoursesPage, page: () => const AllCoursesPage()),
    GetPage(
        name: RoutesName.allCoursesPageDetails,
        page: () => AllCoursesPageDetails()),
    // GetPage(name: RoutesName.dashboardPage, page: () => const DashboardPage()),
    GetPage(
        name: RoutesName.forgotPassPage, page: () => const ForgotPassPage()),
    GetPage(name: RoutesName.maeetingsPage, page: () => const MaeetingsPage()),
    GetPage(name: RoutesName.favoutiesPage, page: () => const FavoutiesPage()),
    GetPage(
        name: RoutesName.subscriptionPage,
        page: () => const SubscriptionPage()),
    GetPage(name: RoutesName.financialPage, page: () => const FinancialPage()),
    GetPage(
        name: RoutesName.categoryDetailsPage,
        page: () => const CategoryDetailsPage()),
    GetPage(
        name: RoutesName.quizDetailsPageOne,
        page: () => const QuizDetailsPageOne()),
    GetPage(
        name: RoutesName.quizDetailsPageTwo,
        page: () => const QuizDetailsPageTwo()),
    GetPage(
        name: RoutesName.notificationPage,
        page: () => const NotificationPage()),
    GetPage(name: RoutesName.searchPage, page: () => SearchPage()),
    GetPage(
        name: RoutesName.chapterDetails, page: () => const ChapterDetails()),
    GetPage(
        name: RoutesName.practiceQuestions,
        page: () => const PracticeQuestionsPage()),
    GetPage(
        name: RoutesName.previousPapers,
        page: () => const PreviousPapersPage()),
    GetPage(name: RoutesName.yourLibrary, page: () => const YourLibraryPage()),
    GetPage(
        name: RoutesName.coursesCheckOutPage,
        page: () => const CoursesCheckOutPage()),
    GetPage(
        name: RoutesName.videoSectionPage,
        page: () => const VideoSectionPage()),
    GetPage(name: RoutesName.blogPage, page: () => const BlogPage()),
    GetPage(name: RoutesName.blogPostPage, page: () => const BlogPostPage()),
    GetPage(
        name: RoutesName.meetingDetailsPage,
        page: () => const MeetingDetailsPage()),
    GetPage(name: RoutesName.calenderPage, page: () => const CalenderWidget()),
    GetPage(
        name: RoutesName.eventEditingPage,
        page: () => const EventEditingPage()),
    GetPage(name: RoutesName.rewardsPage, page: () => const RewardsPage()),
    GetPage(
        name: RoutesName.paymentSuccessPage,
        page: () => const PaymentSuccess()),
    GetPage(
        name: RoutesName.quizQuesAndAnswerPage, page: () => const QuizScreen()),
    GetPage(name: RoutesName.seeAllPage, page: () => const SeeAllPage()),
    GetPage(
        name: RoutesName.meetingWebView, page: () => const MeetingWebView()),
  ];
}

class RoutesName {
  //storage const
  static String token = "token";
  static String id = "id";
  static String categoryId = "categoryId";
  static String isTeacher = "isTeacher";
  static String isFav = "isFav";

  //API const

  /*static String baseUrl = "https://aimpariksha.com/api/";
  static String baseImageUrl = "https://aimpariksha.com";*/
  static String baseUrl = "https://livedivine.in/api/";
  static String baseImageUrl = "https://livedivine.in";
  //routes const

  static String splashScreen = "/SplashScreen";
  static String onboardingPages = "/OnboardingPages";
  // static String signupLandingPage = "/SignupLandingPage";
  static String loginInPagePhone = "/LoginInPagePhone";
  static String loginInPageEmail = "/LoginInPageEmail";
  static String signUpPage = "/SignUpPage";
  static String bottomNavigation = "/BottomNavigationController";
  static String registerPage = "/RegisterPage";
  static String otpVerificationPage = "/OtpVerificationPage";
  static String allCoursesPage = "/AllCoursesPage";
  static String allCoursesPageDetails = "/AllCoursesPageDetails";
  static String dashboardPage = "/DashboardPage";
  static String forgotPassPage = "/ForgotPassPage";
  static String maeetingsPage = "/MaeetingsPage";
  static String favoutiesPage = "/favoutiesPage";
  static String financialPage = "/FinancialPage";
  static String subscriptionPage = "/SubscriptionPage";
  static String learningPage = "/LearningPage";
  static String categoryDetailsPage = "/CategoryDetailsPage";
  static String quizDetailsPageOne = "/QuizDetailsPageOne";
  static String quizDetailsPageTwo = "/QuizDetailsPageTwo";
  static String notificationPage = "/NotificationPage";
  static String searchPage = "/SearchPage";
  static String chapterDetails = "/ChapterDetails";
  static String yourLibrary = "/YourLibraryPage";
  static String practiceQuestions = "/PracticeQuestionsPage";
  static String previousPapers = "/PreviousPapersPage";
  static String coursesCheckOutPage = "/CoursesCheckOutPage";
  static String videoSectionPage = "/VideoSectionPage";
  static String blogPage = "/BlogPage";
  static String blogPostPage = "/BlogPostPage";
  static String meetingDetailsPage = "/MeetingDetailsPage";
  static String calenderPage = "/CalenderWidget";
  static String eventEditingPage = "/EventEditingPage";
  static String rewardsPage = "/RewardsPage";
  static String paymentSuccessPage = "/PaymentSuccess";
  static String quizQuesAndAnswerPage = "/QuizScreen";
  static String seeAllPage = "/SeeAllPage";
  static String meetingWebView = "/MeetingWebView";
  static String forgotPasswordOTPScreen = "/ForgotPasswordOTPScreen";
}
