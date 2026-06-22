class ApiEndpoints {
  const ApiEndpoints._();

  static const login = '/v1/auth/login';
  static const register = '/v1/auth/register';
  static const careerPaths = '/v1/profiles/me/careerPahts';
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
  static const roadmapsBase = '/v1/roadmaps';
  static const myRoadmap = '$roadmapsBase/me';
  static const generateRoadmap = '$roadmapsBase/generate';
  static String roadmapDetails(String roadmapId) =>
      '$roadmapsBase/${_segment(roadmapId)}';
  static String roadmapStepProgress(String roadmapId, String stepId) =>
      '${roadmapDetails(roadmapId)}/steps/${_segment(stepId)}/progress';
  static const courses = '/v1/courses';
  static const recommendedCourses = '$courses/recommended';
  static const savedCourses = '$courses/saved';
  static const courseEnrollments = '$courses/enrollments';
  static String courseDetails(String id) => '$courses/${_segment(id)}';
  static String courseSave(String id) => '${courseDetails(id)}/save';
  static String courseEnroll(String id) => '${courseDetails(id)}/enroll';
  static String courseEnrollment(String id) =>
      '${courseDetails(id)}/enrollment';
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
  static const interviewCareerPaths = '/v1/interviews/career-paths';
  static const interviewSessions = '/v1/interviews/sessions';
  static const legacyInterviewSessions = '/interviews';
  static const startInterview = '/interviews/start';
  static String interviewSessionQuestions(String id) =>
      '$interviewSessions/${_segment(id)}/questions';
  static String interviewQuestionAnswer(String sessionId, String questionId) =>
      '$interviewSessions/${_segment(sessionId)}/questions/${_segment(questionId)}/answer';
  static String interviewQuestionSkip(String sessionId, String questionId) =>
      '$interviewSessions/${_segment(sessionId)}/questions/${_segment(questionId)}/skip';
  static String cancelInterviewSession(String id) =>
      '$interviewSessions/${_segment(id)}/cancel';
  static String finishInterviewSession(String id) =>
      '$interviewSessions/${_segment(id)}/finish';
  static String interviewSessionResult(String id) =>
      '$interviewSessions/${_segment(id)}/result';
  static String interviewResult(String id) =>
      '$legacyInterviewSessions/${_segment(id)}/result';
  static String submitInterviewAnswer(String id) =>
      '$legacyInterviewSessions/${_segment(id)}/answers';
  static const notifications = '/notifications';
  static String markNotificationAsRead(String id) =>
      '$notifications/${_segment(id)}/read';

  static String _segment(String value) => Uri.encodeComponent(value);
}
