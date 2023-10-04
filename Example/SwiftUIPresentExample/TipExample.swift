//
//  TipExample.swift
//  SwiftUIPresentExample
//
//  Created by ribilynn on 2023/10/04.
//

import SwiftUI
import SwiftUIPresent

struct TipView: View {
    
    let sourceRect: CGRect
    var insets: EdgeInsets = EdgeInsets(top: 12, leading: 16, bottom: 12, trailing: 16)
    
    @State var isTipPopoverPresented = false
    var tipContent: AnyView
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            Color.black.opacity(0.4)
            
            RoundedRectangle(cornerRadius: 4)
                .fill(Color.black)
                .frame(
                    width: sourceRect.width + insets.leading + insets.trailing,
                    height: sourceRect.height + insets.top + insets.bottom
                )
                .blendMode(.destinationOut)
                .padding(.leading, sourceRect.minX - insets.leading)
                .padding(.top, sourceRect.minY - insets.top)
        }
        .compositingGroup()
        .overlay(
            Color.clear
                .frame(
                    width: sourceRect.width + insets.leading + insets.trailing,
                    height: sourceRect.height + insets.top + insets.bottom
                )
                .present(
                    isPresented: $isTipPopoverPresented,
                    style: .popover,
                    content: { tipContent }
                )
                .padding(.leading, sourceRect.minX - insets.leading)
                .padding(.top, sourceRect.minY - insets.top)
            ,alignment: .topLeading
        )
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                isTipPopoverPresented = true
            }
        }
        .ignoresSafeArea()
    }
}

final class TipHostingController: UIHostingController<TipView> {
    override init(rootView: TipView) {
        super.init(rootView: rootView)
        modalPresentationStyle = .overCurrentContext
        modalTransitionStyle = .crossDissolve
    }
    
    override func viewDidLoad() {
        view.backgroundColor = .clear
    }
    
    @MainActor required dynamic init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension UIView {
    var globalFrame: CGRect {
        convert(bounds, to: nil)
    }
}

struct TipStyle: PresentationStyle {
    func makeHostingController(_ configuration: PresentationConfiguration) -> TipHostingController {
        TipHostingController(
            rootView: TipView(
                sourceRect: configuration.anchorView.globalFrame,
                tipContent: configuration.content
            )
        )
    }
    
    func update(_ hostingController: TipHostingController, configuration: PresentationConfiguration) {
        hostingController.rootView = TipView(
            sourceRect: configuration.anchorView.globalFrame,
            tipContent: configuration.content
        )
    }
}


struct TipExample: View {
    
    @State private var isTipPresented = false
    
    var body: some View {
        Button {
            isTipPresented = true
        } label: {
            StatusRow("Present Tip", isTipPresented)
        }
        .fixedSize()
        .present(isPresented: $isTipPresented, style: TipStyle()) {
            Text("Some tips")
                .padding()
        }
        .offset(y: -80)
    }
}

struct TipExample_Previews: PreviewProvider {
    static var previews: some View {
        TipExample()
    }
}

