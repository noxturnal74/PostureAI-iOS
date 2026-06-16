import Foundation
import Combine

class WorkoutStorage {
    private let userDefaults = UserDefaults.standard
    private let queue = DispatchQueue(label: \"workout.storage.queue\")
    
    func saveWorkout(_ workout: WorkoutSession) async throws {
        try await withCheckedThrowingContinuation { continuation in
            queue.async {
                do {
                    let data = try JSONEncoder().encode(workout)
                    userDefaults.set(data, forKey: \"workout_\\(workout.id)\")
                    continuation.resume(returning: ())
                } catch {
                    continuation.resume(throwing: error)
                }
            }
        }
    }
    
    func getAllWorkouts() async throws -> [WorkoutSession] {
        try await withCheckedThrowingContinuation { continuation in
            queue.async {
                do {
                    var workouts: [WorkoutSession] = []
                    let keys = userDefaults.dictionaryRepresentation().keys.filter { .hasPrefix(\"workout_\") }
                    for key in keys {
                        if let data = userDefaults.data(forKey: key),
                           let workout = try JSONDecoder().decode(WorkoutSession.self, from: data) {
                            workouts.append(workout)
                        }
                    }
                    continuation.resume(returning: workouts.sorted { .startTime > .startTime })
                } catch {
                    continuation.resume(throwing: error)
                }
            }
        }
    }
    
    func getWorkoutById(_ id: String) async throws -> WorkoutSession? {
        try await withCheckedThrowingContinuation { continuation in
            queue.async {
                do {
                    if let data = userDefaults.data(forKey: \"workout_\\(id)\"),
                       let workout = try JSONDecoder().decode(WorkoutSession.self, from: data) {
                        continuation.resume(returning: workout)
                    } else {
                        continuation.resume(returning: nil)
                    }
                } catch {
                    continuation.resume(throwing: error)
                }
            }
        }
    }
    
    func updateWorkout(_ workout: WorkoutSession) async throws {
        try await saveWorkout(workout)
    }
    
    func deleteWorkout(_ id: String) async throws {
        try await withCheckedThrowingContinuation { continuation in
            queue.async {
                userDefaults.removeObject(forKey: \"workout_\\(id)\")
                continuation.resume(returning: ())
            }
        }
    }
}
