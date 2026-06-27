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
  static const profileMe = '/v1/profiles/me';
  static const profileExperiences = '/v1/profiles/me/experiences';
  static const profileEducation = '/v1/profiles/me/education';
  static const uploadCv = '/v1/cvs/analyze';
  static const analyzeCv = '/v1/cvs/analyze';
  static const latestCvAnalysis = '/v1/cvs/me/latest-analysis';
  static const cvStatus = '/v1/cvs/me/status';
  static const cvHistory = '/v1/cvs/me/history';
  static const cvAnalyses = '/v1/cvs';
  static String cvAnalysisDetails(String id) => '$cvAnalyses/${_segment(id)}';
  static String cvDetails(String id) => '$cvAnalyses/${_segment(id)}';
  static String cvFileUrl(String id) => '/v1/cvs/me/${_segment(id)}/file-url';
  static String profileExperienceById(String id) =>
      '$profileExperiences/${_segment(id)}';
  static String profileEducationById(String id) =>
      '$profileEducation/${_segment(id)}';
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
  static const jobs = '/v1/jobs';
  static const syncJobs = '/v1/jobs/sync';
  static String jobDetails(String id) => '$jobs/${_segment(id)}';
  static const matchedJobs = '/v1/jobs/matched';
  static String saveJob(String id) => '$jobs/${_segment(id)}/save';
  static String applyToJob(String id) => '$jobs/${_segment(id)}/apply';
  static const jobMatches = '/v1/job-matches';
  static const generateJobMatches = '/v1/job-matches/generate';
  static String generateJobMatch(String id) =>
      '$jobMatches/jobs/${_segment(id)}';
  static String jobMatchDetails(String id) => '$jobMatches/${_segment(id)}';
  static const savedJobs = '/v1/jobs/saved';
  static const appliedJobs = '/v1/jobs/applied';
  static String appliedJobStatus(String id) =>
      '$appliedJobs/${_segment(id)}/status';
  static const coverLetters = '/v1/cover-letters';
  static const generateCoverLetter = '/v1/cover-letters/generate';
  static const chatBase = '/v1/chat';
  static const chatSessions = '$chatBase/sessions';
  static String chatMessages(String id) => '$chatBase/${_segment(id)}/messages';
  static String sendChatMessage(String id) => '$chatBase/${_segment(id)}';
  static String deleteSession(String id) => '$chatSessions/${_segment(id)}';
  static String coverLetterDetails(String id) =>
      '$coverLetters/${_segment(id)}';
  static String coverLetterVersions(String id) =>
      '${coverLetterDetails(id)}/versions';
  static String coverLetterExport(String id) =>
      '${coverLetterDetails(id)}/export';
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
  static const notifications = '/v1/notifications';
  static const notificationSettings = '$notifications/settings';
  static const notificationsUnreadCount = '$notifications/unread-count';
  static const notificationsReadAll = '$notifications/read-all';
  static const notificationDevices = '$notifications/devices';
  static String markNotificationAsRead(String id) =>
      '$notifications/${_segment(id)}/read';
  static String dismissNotification(String id) =>
      '$notifications/${_segment(id)}';

  static String _segment(String value) => Uri.encodeComponent(value);
}
