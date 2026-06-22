class ApiEndpoints {
  const ApiEndpoints._();

  static const login = '/v1/auth/login';
  static const register = '/v1/auth/register';
  static const careerPaths = '/v1/profiles/me/careerPahts';

  // Profiles module
  static const profileMe = '/v1/profiles/me';
  static const profileExperiences = '/v1/profiles/me/experiences';
  static const profileEducation = '/v1/profiles/me/education';
  static String profileExperienceById(String id) =>
      '$profileExperiences/${_segment(id)}';
  static String profileEducationById(String id) =>
      '$profileEducation/${_segment(id)}';
  static const forgotPassword = '/auth/forgot-password';
  static const verifyEmail = '/auth/verify-email';
  static const resetPassword = '/auth/reset-password';

  static const profile = '/profile';
  static const updateProfile = '/profile/update';
  static const userSkills = '/profile/skills';

  static const uploadCv = '/v1/cvs/analyze';
  static const analyzeCv = '/v1/cvs/analyze';
  static const latestCvAnalysis = '/v1/cvs/me/latest-analysis';
  static const cvStatus = '/v1/cvs/status';
  static const cvAnalyses = '/v1/cvs';
  static String cvAnalysisDetails(String id) => '$cvAnalyses/${_segment(id)}';
  static String cvDetails(String id) => '$cvAnalyses/${_segment(id)}';

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
  static const savedJobs = '/v1/jobs/saved';
  static const coverLetters = '/cover-letters';
  static const generateCoverLetter = '/cover-letters/generate';

  static const chatSessions = '/chat/sessions';
  static String chatMessages(String id) =>
      '$chatSessions/${_segment(id)}/messages';
  static const sendMessage = '/chat/messages';
  static String deleteSession(String id) =>
      '$chatSessions/${_segment(id)}';

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