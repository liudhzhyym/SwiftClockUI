public enum ClockStyle: Identifiable, CaseIterable {
    case classic
    case artNouveau
    case drawing
    
    public var description: String {
        switch self {
        case .classic: return "Classic"
        case .artNouveau: return "Art Nouveau"
        case .drawing: return "Drawing"
        }
    }
    
    public var id: Int {
        switch self {
        case .classic: return 0
        case .artNouveau: return 1
        case .drawing: return 2
        }
    }
}
