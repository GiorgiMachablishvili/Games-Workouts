

extension String {
    static func userCreate() -> String {
        let baseURL = "https://www.beat-sports.pro/api/v1/users/"
        return "\(baseURL)"
    }

    static func userDelete(userId: String) -> String {
        let baseURL = "https://www.beat-sports.pro/api/v1/users/"
        return "\(baseURL)\(userId)"
    }

    static func createWorkoutCountsAndDate(userId: String) -> String {
        let baseURL = "https://www.beat-sports.pro/api/v1/workout_scores/?user_id="
        return "\(baseURL)\(userId)"
    }

    static func getWorkoutCountsAndDate(userId: String) -> String {
        let baseURL = "https://www.beat-sports.pro/api/v1/workout_scores/"
        return "\(baseURL)\(userId)"
    }

    static func postWorkoutDaysInARow(userId: String, date: String) -> String {
        let baseURL = "https://www.beat-sports.pro/api/v1/training_streaks/?user_id="
        return "\(baseURL)\(userId)&training_date=\(date)"
    }

    static func getWorkoutDaysInARow(userId: String) -> String {
        let baseURL = "https://www.beat-sports.pro/api/v1/training_streaks/"
        return "\(baseURL)\(userId)"
    }

}
