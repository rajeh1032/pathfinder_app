class ApiEndpoints {
  const ApiEndpoints._();

  static const login = '/api/v1/auth/login';
  static const register = '/api/v1/auth/register';
  static const careerPaths = '/api/v1/profiles/me/careerPahts';
  static const forgotPassword = '/auth/forgot-password';
  static const verifyEmail = '/auth/verify-email';
  static const resetPassword = '/auth/reset-password';
  static const profile = '/profile';
  static const updateProfile = '/profile/update';
  static const userSkills = '/profile/skills';
  static const uploadCv = '/cv/upload';
  static const analyzeCv = '/cv/analyze';
  static const cvAnalyses = '/cv/analyses';
  static String cvAnalysisDetails(String id) => '$cvAnalyses/${_segment(id)}';
  static const roadmaps = '/roadmaps';
  static String roadmapDetails(String id) => '$roadmaps/${_segment(id)}';
  static String roadmapSteps(String id) => '${roadmapDetails(id)}/steps';
  static const courses = '/courses';
  static String courseDetails(String id) => '$courses/${_segment(id)}';
  static const jobs = '/jobs';
  static String jobDetails(String id) => '$jobs/${_segment(id)}';
  static const jobMatches = '/jobs/matches';
  static const savedJobs = '/jobs/saved';
  static const coverLetters = '/cover-letters';
  static const generateCoverLetter = '/cover-letters/generate';
  static const chatSessions = '/chat/sessions';
  static String chatMessages(String id) =>
      '$chatSessions/${_segment(id)}/messages';
  static const sendMessage = '/chat/messages';
  static const interviewSessions = '/interviews';
  static const startInterview = '/interviews/start';
  static String submitInterviewAnswer(String id) =>
      '$interviewSessions/${_segment(id)}/answers';
  static String interviewResult(String id) =>
      '$interviewSessions/${_segment(id)}/result';
  static const notifications = '/notifications';
  static String markNotificationAsRead(String id) =>
      '$notifications/${_segment(id)}/read';

  static String _segment(String value) => Uri.encodeComponent(value);
}
