import SwiftUI

// MARK: - CameraFeedView

struct CameraFeedView: View {
    @ObservedObject var viewModel: WorkoutViewModel
    @State private var cameraPermissionAuthorized = false
    @State private var captureSession: AVCaptureSession?
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                if cameraPermissionAuthorized {
                    CameraPreviewLayer(session: captureSession)
                        .edgesIgnoringSafeArea(.all)
                    
                    OverlayContent()
                } else {
                    PermissionView { requestPermission() }
                }
            }
        }
        .onAppear { requestPermission() }
    }
    
    func requestPermission() {
        switch AVCaptureDevice.authorizationStatus(for: .video) {
        case .authorized:
            cameraPermissionAuthorized = true
            startCamera()
        case .denied, .restricted:
            cameraPermissionAuthorized = false
        case .notDetermined:
            AVCaptureDevice.requestAccess(for: .video) { granted in
                DispatchQueue.main.async {
                    if granted {
                        cameraPermissionAuthorized = true
                        startCamera()
                    }
                }
            }
        @unknown default:
            cameraPermissionAuthorized = false
        }
    }
    
    func startCamera() {
        captureSession = AVCaptureSession()
        captureSession?.sessionPreset = .high
        
        guard let captureSession = captureSession,
              let videoDevice = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .back),
              let videoInput = try? AVCaptureDeviceInput(device: videoDevice),
              captureSession.canAddInput(videoInput) else {
            return
        }
        
        captureSession.addInput(videoInput)
        
        let previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        previewLayer.videoGravity = .resizeAspectFill
        
        DispatchQueue.global(qos: .userInitiated).async {
            captureSession.startRunning()
        }
    }
    
    @ViewBuilder
    func OverlayContent() -> some View {
        // Posture analysis overlay
        if viewModel.isRecording {
            PostureOverlay(landmarks: viewModel.poseLandmarks)
        }
        
        // Feedback overlay
        if viewModel.showFeedback {
            FeedbackView(message: viewModel.feedbackMessage) {
                viewModel.showFeedback = false
            }
        }
        
        // Rep counter
        VStack {
            Spacer()
            HStack {
                Text(\"Reps: \\(viewModel.currentRep)/\\(viewModel.targetReps)\")
                    .font(.title2)
                    .bold()
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.black.opacity(0.5))
                    .cornerRadius(12)
                Spacer()
            }
            .padding(.bottom, 100)
        }
    }
}

struct CameraPreviewLayer: UIViewRepresentable {
    let session: AVCaptureSession?
    
    func makeUIView(context: Context) -> UIView {
        let view = UIView()
        view.backgroundColor = .black
        
        if let session = session {
            let previewLayer = AVCaptureVideoPreviewLayer(session: session)
            previewLayer.videoGravity = .resizeAspectFill
            previewLayer.frame = view.bounds
            view.layer.addSublayer(previewLayer)
        }
        
        return view
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {
        if let layer = uiView.layer.sublayers?.first as? AVCaptureVideoPreviewLayer,
           let session = session {
            layer.session = session
            layer.frame = uiView.bounds
        }
    }
}

struct PostureOverlay: View {
    let landmarks: [PoseLandmark]
    
    var body: some View {
        Canvas { context, size in
            for landmark in landmarks {
                let point = CGPoint(x: landmark.x * size.width, y: landmark.y * size.height)
                context.fill(Path(circleCenter: point, radius: 3), with: .color(.accent))
            }
            
            // Draw connections between landmarks
            // This would draw the pose skeleton
        }
    }
}

struct FeedbackView: View {
    let message: String
    let onContinue: () -> Void
    
    var body: some View {
        Color.black.opacity(0.8)
            .ignoresSafeArea()
            .onTapGesture { onContinue() }
            .overlay(
                VStack(spacing: 24) {
                    Image(systemName: \"sparkles\")
                        .font(.system(size: 64))
                        .foregroundColor(.accent)
                    Text(message)
                        .font(.title2)
                        .bold()
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 32)
                    Button(\"Continue\") { onContinue() }
                        .buttonStyle(.borderedProminent)
                        .padding(.top, 16)
                }
                .padding(32)
                .background(Color.black)
                .cornerRadius(24)
            )
    }
}

struct PermissionView: View {
    let onAuthorize: () -> Void
    
    var body: some View {
        VStack(spacing: 24) {
            Image(systemName: \"camera.fill\")
                .font(.system(size: 80))
                .foregroundColor(.accent)
            Text(\"Camera Access Required\")
                .font(.title2)
                .bold()
            Text(\"PostureAI needs camera access to analyze your workout form in real-time.\")
                .font(.body)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 32)
            Button(\"Allow Camera Access\") { onAuthorize() }
                .buttonStyle(.borderedProminent)
                .padding(.top, 16)
        }
        .padding()
        .multilineTextAlignment(.center)
    }
}
