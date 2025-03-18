

import Foundation

struct WorkoutStepsProvider {

    static func setupTennisWorkoutSteps() -> [ViewInfo] {
        return [
            ViewInfo(title: "Warm-up:", description: "Jog around the court.", timer: "3"),
            ViewInfo(title: "Warm-up:", description: "Stretching for legs, back, arms and shoulders.", timer: "2"),

            ViewInfo(title: "Technique exercises:", description: "Serving exercise.", timer: "3"),
            ViewInfo(title: "Technique exercises:", description: "Forehand exercise.", timer: "3"),
            ViewInfo(title: "Technique exercises:", description: "Backhand exercise.", timer: "4"),

            ViewInfo(title: "Reaction and speed exercises:", description: "Quick Reaction mini-game.", timer: "2"),
            ViewInfo(title: "Reaction and speed exercises:", description: "Running around the court exercise.", timer: "3"),

            ViewInfo(title: "Wrap-up:", description: "A series of shots into a mini box.", timer: "2"),
            ViewInfo(title: "Wrap-up:", description: "Relaxation and stretching.", timer: "3")
        ]
    }

    static func setupBasketballWorkoutSteps() -> [ViewInfo] {
        return [
            ViewInfo(title: "Warm-up:", description: "Running around the perimeter of the court at a moderate pace.", timer: "3"),
            ViewInfo(title: "Warm-up:", description: "Stretching for legs, back, arms and shoulders.", timer: "2"),

            ViewInfo(title: "Technique exercises:", description: "Ball exercise:", timer: "3"),
            ViewInfo(title: "Technique exercises:", description: "Throwing exercise:", timer: "3"),
            ViewInfo(title: "Technique exercises:", description: "Defense exercise:", timer: "4"),
            ViewInfo(title: "Technique exercises:", description: "Throw blocking exercise.", timer: "2"),
            ViewInfo(title: "Technique exercises:", description: "Ball interceptions exercise.", timer: "2"),

            ViewInfo(title: "Reaction and speed exercises:", description: "Jumping in place and jumping over hurdles.", timer: "2"),
            ViewInfo(title: "Reaction and speed exercises:", description: "Running short intervals with changes of pace (sprints, half-speed running, moderate speed running).", timer: "3"),

            ViewInfo(title: "Completion:", description: "Stretching for legs, back, arms and shoulders.", timer: "3"),
            ViewInfo(title: "Completion:", description: "Rest and regain breathing.", timer: "3")
        ]
    }

    static func setupVolleyballWorkoutSteps() -> [ViewInfo] {
        return [
            ViewInfo(title: "Warm-up:", description: "Running around the court or training area.", timer: "2"),
            ViewInfo(title: "Warm-up:", description: "Stretching for legs, back, arms and shoulders.", timer: "2"),

            ViewInfo(title: "Technique exercises:", description: "Ball serves:", timer: "3"),
            ViewInfo(title: "Technique exercises:", description: "Passing exercise:", timer: "3"),
            ViewInfo(title: "Technique exercises:", description: "Attacking exercise:", timer: "4"),
            ViewInfo(title: "Technique exercises:", description: "Hitting the ball into the center with power shots.", timer: "2"),

            ViewInfo(title: "Reaction and speed exercises:", description: "Fast reaction exercise:", timer: "2"),
            ViewInfo(title: "Reaction and speed exercises:", description: "Speed exercise:", timer: "3"),
            ViewInfo(title: "Reaction and speed exercises:", description: "Fast jogging in short intervals.", timer: "2"),

            ViewInfo(title: "Completion:", description: "Stretching for legs, back, arms and shoulders.", timer: "2"),
            ViewInfo(title: "Completion:", description: "Rest and breathing recovery.", timer: "3")
        ]
    }

    static func setupSoccerWorkoutSteps() -> [ViewInfo] {
        return [
            ViewInfo(title: "Warm-up:", description: "Running around the perimeter of the field at a moderate pace.", timer: "3"),
            ViewInfo(title: "Warm-up:", description: "Stretching for legs, back, arms and shoulders.", timer: "2"),

            ViewInfo(title: "Technique exercises:", description: "Passing exercise:", timer: "3"),
            ViewInfo(title: "Technique exercises:", description: "Dribbling exercise:", timer: "3"),
            ViewInfo(title: "Technique exercises:", description: "Kicking exercise:", timer: "4"),
            ViewInfo(title: "Technique exercises:", description: "Kicks at goal from various positions.", timer: "2"),
            ViewInfo(title: "Technique exercises:", description: "Kicks with a partner, passing the ball for a kick.", timer: "2"),

            ViewInfo(title: "Reaction and speed exercises:", description: "Jumping over hurdles.", timer: "2"),
            ViewInfo(title: "Reaction and speed exercises:", description: "Running short intervals with changes of pace (sprints, half-speed running, moderate speed running).", timer: "3"),

            ViewInfo(title: "Wrap-up:", description: "Stretching exercises for legs, back, arms and shoulders.", timer: "3"),
            ViewInfo(title: "Wrap-up:", description: "Rest and breathing recovery.", timer: "3")
        ]
    }

    static func setupBaseballWorkoutSteps() -> [ViewInfo] {
        return [
            ViewInfo(title: "Warm-up:", description: "Jog around the bases.", timer: "3"),
            ViewInfo(title: "Warm-up:", description: "Arm circles and shoulder stretching.", timer: "2"),

            ViewInfo(title: "Technique exercises:", description: "Batting stance and swing drills.", timer: "4"),
            ViewInfo(title: "Technique exercises:", description: "Throwing accuracy drills.", timer: "3"),
            ViewInfo(title: "Technique exercises:", description: "Fielding ground balls.", timer: "3"),

            ViewInfo(title: "Reaction and speed exercises:", description: "Sprint between bases.", timer: "3"),
            ViewInfo(title: "Reaction and speed exercises:", description: "Quick glove reaction drill.", timer: "2"),

            ViewInfo(title: "Wrap-up:", description: "Batting practice with live pitching.", timer: "3"),
            ViewInfo(title: "Wrap-up:", description: "Cool down stretches.", timer: "3")
        ]
    }

    static func setupSwimmingWorkoutSteps() -> [ViewInfo] {
        return [
            ViewInfo(title: "Warm-up:", description: "Light swimming with freestyle stroke.", timer: "3"),
            ViewInfo(title: "Warm-up:", description: "Dynamic stretching for shoulders and legs.", timer: "2"),

            ViewInfo(title: "Technique exercises:", description: "Freestyle stroke technique.", timer: "3"),
            ViewInfo(title: "Technique exercises:", description: "Backstroke technique.", timer: "3"),
            ViewInfo(title: "Technique exercises:", description: "Breaststroke kick practice.", timer: "4"),

            ViewInfo(title: "Reaction and speed exercises:", description: "Underwater push-off sprint.", timer: "2"),
            ViewInfo(title: "Reaction and speed exercises:", description: "50m sprint swim.", timer: "3"),

            ViewInfo(title: "Wrap-up:", description: "Easy floating and stretching.", timer: "2"),
            ViewInfo(title: "Wrap-up:", description: "Cooldown with slow laps.", timer: "3")
        ]
    }

    static func setupAmericanFootballWorkoutSteps() -> [ViewInfo] {
        return [
            ViewInfo(title: "Warm-up:", description: "High knees and butt kicks.", timer: "3"),
            ViewInfo(title: "Warm-up:", description: "Arm and leg dynamic stretches.", timer: "2"),

            ViewInfo(title: "Technique exercises:", description: "Throwing accuracy drills.", timer: "3"),
            ViewInfo(title: "Technique exercises:", description: "Footwork agility ladder.", timer: "3"),
            ViewInfo(title: "Technique exercises:", description: "Tackling form drills.", timer: "4"),

            ViewInfo(title: "Reaction and speed exercises:", description: "Cone drill for quick turns.", timer: "2"),
            ViewInfo(title: "Reaction and speed exercises:", description: "Sprint drills with direction change.", timer: "3"),

            ViewInfo(title: "Wrap-up:", description: "Short pass and catch drills.", timer: "2"),
            ViewInfo(title: "Wrap-up:", description: "Cool down stretches.", timer: "3")
        ]
    }

    static func setupCyclingWorkoutSteps() -> [ViewInfo] {
        return [
            ViewInfo(title: "Warm-up:", description: "Light pedaling at low resistance.", timer: "3"),
            ViewInfo(title: "Warm-up:", description: "Stretching for legs and lower back.", timer: "2"),

            ViewInfo(title: "Technique exercises:", description: "Cadence control drills.", timer: "3"),
            ViewInfo(title: "Technique exercises:", description: "Hill climb simulation.", timer: "3"),
            ViewInfo(title: "Technique exercises:", description: "Sprint interval training.", timer: "4"),

            ViewInfo(title: "Reaction and speed exercises:", description: "Fast pedaling drill.", timer: "2"),
            ViewInfo(title: "Reaction and speed exercises:", description: "Quick gear shifting challenge.", timer: "3"),

            ViewInfo(title: "Wrap-up:", description: "Cool-down ride at low intensity.", timer: "2"),
            ViewInfo(title: "Wrap-up:", description: "Full-body stretching.", timer: "3")
        ]
    }

    static func setupBoxingWorkoutSteps() -> [ViewInfo] {
        return [
            ViewInfo(title: "Warm-up:", description: "Jump rope drill.", timer: "3"),
            ViewInfo(title: "Warm-up:", description: "Shadow boxing with light movements.", timer: "2"),

            ViewInfo(title: "Technique exercises:", description: "Jab and cross combination drill.", timer: "3"),
            ViewInfo(title: "Technique exercises:", description: "Footwork agility drill.", timer: "3"),
            ViewInfo(title: "Technique exercises:", description: "Uppercut and hook punch practice.", timer: "4"),

            ViewInfo(title: "Reaction and speed exercises:", description: "Reflex reaction drill with coach.", timer: "2"),
            ViewInfo(title: "Reaction and speed exercises:", description: "Speed punching bag workout.", timer: "3"),

            ViewInfo(title: "Wrap-up:", description: "Slow shadow boxing and breathing control.", timer: "2"),
            ViewInfo(title: "Wrap-up:", description: "Cool down with full-body stretching.", timer: "3")
        ]
    }

    static func setupGolfWorkoutSteps() -> [ViewInfo] {
        return [
            ViewInfo(title: "Warm-up:", description: "Gentle swings with a club.", timer: "3"),
            ViewInfo(title: "Warm-up:", description: "Shoulder and wrist mobility exercises.", timer: "2"),

            ViewInfo(title: "Technique exercises:", description: "Grip and stance alignment practice.", timer: "3"),
            ViewInfo(title: "Technique exercises:", description: "Swing tempo drill.", timer: "3"),
            ViewInfo(title: "Technique exercises:", description: "Chipping accuracy practice.", timer: "4"),

            ViewInfo(title: "Reaction and speed exercises:", description: "Target aiming under time pressure.", timer: "2"),
            ViewInfo(title: "Reaction and speed exercises:", description: "Putting challenge with countdown timer.", timer: "3"),

            ViewInfo(title: "Wrap-up:", description: "Slow swings for relaxation.", timer: "2"),
            ViewInfo(title: "Wrap-up:", description: "Stretching for shoulders and lower back.", timer: "3")
        ]
    }

    static func setupRunWorkoutSteps() -> [ViewInfo] {
        return [
            ViewInfo(title: "Warm-up:", description: "Light jogging and dynamic stretching.", timer: "3"),
            ViewInfo(title: "Warm-up:", description: "High knees and butt kicks.", timer: "2"),

            ViewInfo(title: "Technique exercises:", description: "Acceleration drill.", timer: "3"),
            ViewInfo(title: "Technique exercises:", description: "Sprint form technique.", timer: "3"),
            ViewInfo(title: "Technique exercises:", description: "Starting block practice.", timer: "4"),

            ViewInfo(title: "Reaction and speed exercises:", description: "Quick reaction to starting signal.", timer: "2"),
            ViewInfo(title: "Reaction and speed exercises:", description: "30m sprint challenge.", timer: "3"),

            ViewInfo(title: "Wrap-up:", description: "Jogging cooldown.", timer: "2"),
            ViewInfo(title: "Wrap-up:", description: "Full-body stretching.", timer: "3")
        ]
    }

    static func setupWrestlingWorkoutSteps() -> [ViewInfo] {
        return [
            ViewInfo(title: "Warm-up:", description: "Light jogging and stretching.", timer: "3"),
            ViewInfo(title: "Warm-up:", description: "Neck and shoulder mobility drills.", timer: "2"),

            ViewInfo(title: "Technique exercises:", description: "Takedown drills.", timer: "3"),
            ViewInfo(title: "Technique exercises:", description: "Escape technique practice.", timer: "3"),
            ViewInfo(title: "Technique exercises:", description: "Pinning control drills.", timer: "4"),

            ViewInfo(title: "Reaction and speed exercises:", description: "Reflex partner drill.", timer: "2"),
            ViewInfo(title: "Reaction and speed exercises:", description: "Quick reaction stance changes.", timer: "3"),

            ViewInfo(title: "Wrap-up:", description: "Slow rolling to relax muscles.", timer: "2"),
            ViewInfo(title: "Wrap-up:", description: "Deep stretching for flexibility.", timer: "3")
        ]
    }

    static func setupGymnasticsWorkoutSteps() -> [ViewInfo] {
        return [
            ViewInfo(title: "Warm-up:", description: "Light stretching and mobility drills.", timer: "3"),
            ViewInfo(title: "Warm-up:", description: "Basic handstand and balance work.", timer: "2"),

            ViewInfo(title: "Technique exercises:", description: "Cartwheel practice.", timer: "3"),
            ViewInfo(title: "Technique exercises:", description: "Parallel bars technique.", timer: "3"),
            ViewInfo(title: "Technique exercises:", description: "Floor routine drills.", timer: "4"),

            ViewInfo(title: "Reaction and speed exercises:", description: "Quick balance recovery drills.", timer: "2"),
            ViewInfo(title: "Reaction and speed exercises:", description: "Fast transition exercises.", timer: "3"),

            ViewInfo(title: "Wrap-up:", description: "Gentle stretching and relaxation.", timer: "2"),
            ViewInfo(title: "Wrap-up:", description: "Slow deep breathing techniques.", timer: "3")
        ]
    }

    static func setupTableTennisWorkoutSteps() -> [ViewInfo] {
        return [
            ViewInfo(title: "Warm-up:", description: "Light jogging and arm stretches.", timer: "3"),
            ViewInfo(title: "Warm-up:", description: "Shadow swings for forehand and backhand.", timer: "2"),

            ViewInfo(title: "Technique exercises:", description: "Forehand drive practice.", timer: "3"),
            ViewInfo(title: "Technique exercises:", description: "Backhand loop drill.", timer: "3"),
            ViewInfo(title: "Technique exercises:", description: "Footwork movement drill.", timer: "4"),

            ViewInfo(title: "Reaction and speed exercises:", description: "Quick rally challenge.", timer: "2"),
            ViewInfo(title: "Reaction and speed exercises:", description: "Fast spin return drill.", timer: "3"),

            ViewInfo(title: "Wrap-up:", description: "Relaxed ball control practice.", timer: "2"),
            ViewInfo(title: "Wrap-up:", description: "Wrist and shoulder stretches.", timer: "3")
        ]
    }

    static func setupIceHockeyWorkoutSteps() -> [ViewInfo] {
        return [
            ViewInfo(title: "Warm-up:", description: "Skating warm-up laps.", timer: "3"),
            ViewInfo(title: "Warm-up:", description: "Stickhandling drills while skating.", timer: "2"),

            ViewInfo(title: "Technique exercises:", description: "Slapshot accuracy drill.", timer: "3"),
            ViewInfo(title: "Technique exercises:", description: "Defensive stance and movement.", timer: "3"),
            ViewInfo(title: "Technique exercises:", description: "Passing under pressure drill.", timer: "4"),

            ViewInfo(title: "Reaction and speed exercises:", description: "Puck reaction training.", timer: "2"),
            ViewInfo(title: "Reaction and speed exercises:", description: "Fast skating sprints.", timer: "3"),

            ViewInfo(title: "Wrap-up:", description: "Slow skating and deep breathing.", timer: "2"),
            ViewInfo(title: "Wrap-up:", description: "Stretching for legs and shoulders.", timer: "3")
        ]
    }

    static func setupRugbyWorkoutSteps() -> [ViewInfo] {
        return [
            ViewInfo(title: "Warm-up:", description: "Light jogging and mobility drills.", timer: "3"),
            ViewInfo(title: "Warm-up:", description: "Dynamic stretching for legs and shoulders.", timer: "2"),

            ViewInfo(title: "Technique exercises:", description: "Passing accuracy drills.", timer: "3"),
            ViewInfo(title: "Technique exercises:", description: "Tackling technique practice.", timer: "3"),
            ViewInfo(title: "Technique exercises:", description: "Scrum formation and pressure drill.", timer: "4"),

            ViewInfo(title: "Reaction and speed exercises:", description: "Agility cone drills.", timer: "2"),
            ViewInfo(title: "Reaction and speed exercises:", description: "Sprint and reaction drills.", timer: "3"),

            ViewInfo(title: "Wrap-up:", description: "Short passing challenge.", timer: "2"),
            ViewInfo(title: "Wrap-up:", description: "Stretching and breathing exercises.", timer: "3")
        ]
    }

    static func setupMMAWorkoutSteps() -> [ViewInfo] {
        return [
            ViewInfo(title: "Warm-up:", description: "Jump rope warm-up.", timer: "3"),
            ViewInfo(title: "Warm-up:", description: "Shadowboxing with light movement.", timer: "2"),

            ViewInfo(title: "Technique exercises:", description: "Jab-cross combination drills.", timer: "3"),
            ViewInfo(title: "Technique exercises:", description: "Grappling takedown practice.", timer: "3"),
            ViewInfo(title: "Technique exercises:", description: "Kick and knee strike drill.", timer: "4"),

            ViewInfo(title: "Reaction and speed exercises:", description: "Reflex partner drill.", timer: "2"),
            ViewInfo(title: "Reaction and speed exercises:", description: "Quick defense reaction training.", timer: "3"),

            ViewInfo(title: "Wrap-up:", description: "Light sparring for cooldown.", timer: "2"),
            ViewInfo(title: "Wrap-up:", description: "Deep stretching and breathing.", timer: "3")
        ]
    }

    static func setupRowingWorkoutSteps() -> [ViewInfo] {
        return [
            ViewInfo(title: "Warm-up:", description: "Slow rowing at low resistance.", timer: "3"),
            ViewInfo(title: "Warm-up:", description: "Dynamic stretching for back and legs.", timer: "2"),

            ViewInfo(title: "Technique exercises:", description: "Proper stroke technique drill.", timer: "3"),
            ViewInfo(title: "Technique exercises:", description: "Drive and recovery phase focus.", timer: "3"),
            ViewInfo(title: "Technique exercises:", description: "Power stroke challenge.", timer: "4"),

            ViewInfo(title: "Reaction and speed exercises:", description: "30-second sprint row.", timer: "2"),
            ViewInfo(title: "Reaction and speed exercises:", description: "Fast start and slow finish drill.", timer: "3"),

            ViewInfo(title: "Wrap-up:", description: "Gentle rowing cooldown.", timer: "2"),
            ViewInfo(title: "Wrap-up:", description: "Full-body stretching.", timer: "3")
        ]
    }

    static func setupLacrosseWorkoutSteps() -> [ViewInfo] {
        return [
            ViewInfo(title: "Warm-up:", description: "Light jogging and stick control drill.", timer: "3"),
            ViewInfo(title: "Warm-up:", description: "Stretching for legs and shoulders.", timer: "2"),

            ViewInfo(title: "Technique exercises:", description: "Passing accuracy drills.", timer: "3"),
            ViewInfo(title: "Technique exercises:", description: "Dodging and movement drill.", timer: "3"),
            ViewInfo(title: "Technique exercises:", description: "Shot accuracy and power practice.", timer: "4"),

            ViewInfo(title: "Reaction and speed exercises:", description: "Quick catch and pass challenge.", timer: "2"),
            ViewInfo(title: "Reaction and speed exercises:", description: "Sprint between goalposts.", timer: "3"),

            ViewInfo(title: "Wrap-up:", description: "Relaxed stick handling drill.", timer: "2"),
            ViewInfo(title: "Wrap-up:", description: "Cool down with stretching.", timer: "3")
        ]
    }

    static func setupBadmintonWorkoutSteps() -> [ViewInfo] {
        return [
            ViewInfo(title: "Warm-up:", description: "Light jogging and shoulder rotations.", timer: "3"),
            ViewInfo(title: "Warm-up:", description: "Shadow swings for forehand and backhand.", timer: "2"),

            ViewInfo(title: "Technique exercises:", description: "Drop shot and clear drills.", timer: "3"),
            ViewInfo(title: "Technique exercises:", description: "Footwork agility drill.", timer: "3"),
            ViewInfo(title: "Technique exercises:", description: "Smash and net shot practice.", timer: "4"),

            ViewInfo(title: "Reaction and speed exercises:", description: "Quick rally reaction drill.", timer: "2"),
            ViewInfo(title: "Reaction and speed exercises:", description: "Fast shuttle return challenge.", timer: "3"),

            ViewInfo(title: "Wrap-up:", description: "Light rally and movement cooldown.", timer: "2"),
            ViewInfo(title: "Wrap-up:", description: "Wrist and shoulder stretching.", timer: "3")
        ]
    }
}
