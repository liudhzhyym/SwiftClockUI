import SwiftUI

struct SteampunkIndicators: View {
    @Environment(\.clockConfiguration) var configuration
    static let marginRatio: CGFloat = 1/5
    static let decorationScale: CGFloat = 7/10
    static let lineWidthRatio: CGFloat = 1/100
    static let decorationLineWidthRatio: CGFloat = lineWidthRatio * 1/decorationScale

    var body: some View {
        ZStack {
            ZStack() {
                mainCogwheel
                moon
                gears.mask(moon)
            }.scaleEffect(Self.decorationScale)
            circles
            numbers
        }.aspectRatio(contentMode: .fit)
    }

    private var mainCogwheel: some View {
        Cogwheel()
            .scale(0.8)
            .strokeProportionally(Self.decorationLineWidthRatio)
            .modifier(RotateOnAppear())
    }

    private var circles: some View {
        ZStack() {
            Circle()
                .scale(21/25)
                .strokeProportionally(Self.lineWidthRatio)
            Circle()
                .scale(20/25)
                .strokeProportionally(Self.lineWidthRatio)
        }
    }

    private var moon: some View {
        ZStack {
            Moon().fill(Color.background)
            Moon().strokeProportionally(Self.decorationLineWidthRatio)
        }.modifier(BalanceOnAppear())
    }

    private var gears: some View {
        GeometryReader { geometry in
            Cogwheel(toothCount: 12, armCount: 3, addExtraHoles: false)
                .scale(1/5)
                .strokeProportionally(Self.decorationLineWidthRatio)
                .modifier(RotateOnAppear(clockwise: false))
                .position(x: geometry.radius * 1/5, y: geometry.radius * 4/3)
            Cogwheel(toothCount: 8, armCount: 5, addExtraHoles: false)
                .scale(1/6)
                .fill(style: .init(eoFill: true, antialiased: true))
                .modifier(RotateOnAppear(clockwise: true))
                .position(x: geometry.radius * 2 * 7/27, y: geometry.radius * 3/2)
            Cogwheel(toothCount: 12, armCount: 8, addExtraHoles: false)
                .scale(1/4)
                .strokeProportionally(Self.decorationLineWidthRatio)
                .modifier(RotateOnAppear(clockwise: false))
                .position(x: geometry.radius * 2/3, y: geometry.radius * 28/15)
        }
    }

    private var numbers: some View {
        ForEach(RomanNumber.numbers(configuration: configuration), id: \.self) { romanNumber in
            Plate(type: self.plateType(for: romanNumber), text: romanNumber)
                .scaleEffect(3/19)
                .modifier(PositionInCircle(angle: RomanNumber.angle(for: romanNumber), marginRatio: Self.marginRatio))
        }
    }

    private func plateType(for romanNumber: String) -> Plate.PlateType {
        RomanNumber.limitedNumbers.contains(romanNumber) ? .hard : .soft
    }
}

struct SteampunkIndicators_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Circle().stroke()
            SteampunkIndicators()
        }.padding()
    }
}

struct SteampunkIndicatorsWithLimitedHours_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Circle().stroke()
            SteampunkIndicators().environment(\.clockConfiguration, .init(isLimitedHoursShown: true, isMinuteIndicatorsShown: true, isHourIndicatorsShown: true))
        }.padding()
    }
}
