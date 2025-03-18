

import UIKit

struct WorkoutScore: Codable {
    let workoutDate: String
    let soccerWorkoutCount: Int
    let basketballWorkoutCount: Int
    let volleyballWorkoutCount: Int
    let tennisWorkoutCount: Int
    let americanFootballWorkoutCount: Int
    let badmintonWorkoutCount: Int
    let baseballWorkoutCount: Int
    let rugbyWorkoutCount: Int
    let boxingWorkoutCount: Int
    let cyclingWorkoutCount: Int
    let golfWorkoutCount: Int
    let gymnasticsWorkoutCount: Int
    let iceHockeyWorkoutCount: Int
    let lacrosseWorkoutCount: Int
    let mmaWorkoutCount: Int
    let wrestlingWorkoutCount: Int
    let rowingWorkoutCount: Int
    let runningWorkoutCount: Int
    let swimmingWorkoutCount: Int
    let tableTennisWorkoutCount: Int
    let workoutTime: String

    enum CodingKeys: String, CodingKey {
        case workoutDate = "workout_date"
        case soccerWorkoutCount = "soccer_workout_count"
        case basketballWorkoutCount = "basketball_workout_count"
        case volleyballWorkoutCount = "volleyball_workout_count"
        case tennisWorkoutCount = "tennis_workout_count"
        case americanFootballWorkoutCount = "americanFootball_workout_count"
        case badmintonWorkoutCount = "badminton_workout_count"
        case baseballWorkoutCount = "baseball_workout_count"
        case rugbyWorkoutCount = "rugby_workout_count"
        case boxingWorkoutCount = "boxing_workout_count"
        case cyclingWorkoutCount = "cycling_workout_count"
        case golfWorkoutCount = "golf_workout_count"
        case gymnasticsWorkoutCount = "gymnastics_workout_count"
        case iceHockeyWorkoutCount = "iceHockey_workout_count"
        case lacrosseWorkoutCount = "lacrosse_workout_count"
        case mmaWorkoutCount = "mma_workout_count"
        case wrestlingWorkoutCount = "wrestling_workout_count"
        case rowingWorkoutCount = "rowing_workout_count"
        case runningWorkoutCount = "running_workout_count"
        case swimmingWorkoutCount = "swimming_workout_count"
        case tableTennisWorkoutCount = "tableTennis_workout_count"
        case workoutTime = "workout_time"
    }
}
