

import UIKit

struct WorkoutScore: Codable {
    let workoutDate: String
    let soccerWorkoutCount: Int
    let basketballWorkoutCount: Int
    let volleyballWorkoutCount: Int
    let tennisWorkoutCount: Int
    let workoutTime: String

    enum CodingKeys: String, CodingKey {
        case workoutDate = "workout_date"
        case soccerWorkoutCount = "soccer_workout_count"
        case basketballWorkoutCount = "basketball_workout_count"
        case volleyballWorkoutCount = "volleyball_workout_count"
        case tennisWorkoutCount = "tennis_workout_count"
        case workoutTime = "workout_time"
    }
}
