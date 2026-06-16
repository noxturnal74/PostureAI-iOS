import Foundation

// MARK: - Repository Protocol

protocol Repository {
    associatedtype Model: Identifiable, Codable
    func getAll() async throws -> [Model]
    func getById(_ id: String) async throws -> Model?
    func create(_ model: Model) async throws
    func update(_ model: Model) async throws
    func delete(_ id: String) async throws
}

// MARK: - Workout Repository

class WorkoutRepository: Repository {
    typealias Model = WorkoutSession
    
    private var storage: WorkoutStorage
    private var poseDetector: PoseDetector
    
    init(storage: WorkoutStorage = WorkoutStorage(), poseDetector: PoseDetector = PoseDetector()) {
        self.storage = storage
        self.poseDetector = poseDetector
    }
    
    func create(_ workout: WorkoutSession) async throws {
        try await storage.saveWorkout(workout)
    }
    
    func getAll() async throws -> [WorkoutSession] {
        try await storage.getAllWorkouts()
    }
    
    func getById(_ id: String) async throws -> WorkoutSession? {
        try await storage.getWorkoutById(id)
    }
    
    func update(_ workout: WorkoutSession) async throws {
        try await storage.updateWorkout(workout)
    }
    
    func delete(_ id: String) async throws {
        try await storage.deleteWorkout(id)
    }
}
