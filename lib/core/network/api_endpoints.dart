class ApiEndpoints {
  const ApiEndpoints._();

  static const login = '/auth/login';
  static const register = '/auth/register';
  static const forgotPassword = '/auth/forgot-password';
  static const verifyEmail = '/auth/verify-email';
  static const resetPassword = '/auth/reset-password';
  static const profile = '/profile';
  static const updateProfile = '/profile/update';
  static const userSkills = '/profile/skills';
  static const uploadCv = '/cv/upload';
  static const analyzeCv = '/cv/analyze';
  static const cvAnalyses = '/cv/analyses';
  static const cvAnalysisDetails = '/cv/analyses/:id';
  static const roadmaps = '/roadmaps';
  static const roadmapDetails = '/roadmaps/:id';
  static const roadmapSteps = '/roadmaps/:id/steps';
  static const courses = '/courses';
  static const courseDetails = '/courses/:id';
  static const jobs = '/jobs';
  static const jobDetails = '/jobs/:id';
  static const jobMatches = '/jobs/matches';
  static const savedJobs = '/jobs/saved';
  static const coverLetters = '/cover-letters';
  static const generateCoverLetter = '/cover-letters/generate';
  static const chatSessions = '/chat/sessions';
  static const chatMessages = '/chat/sessions/:id/messages';
  static const sendMessage = '/chat/messages';
  static const interviewSessions = '/interviews';
  static const startInterview = '/interviews/start';
  static const submitInterviewAnswer = '/interviews/:id/answers';
  static const interviewResult = '/interviews/:id/result';
  static const notifications = '/notifications';
  static const markNotificationAsRead = '/notifications/:id/read';
}
