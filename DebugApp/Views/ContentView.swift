//
//  ContentView.swift
//  DebugApp
//
//  Created by Yugo Sugiyama on 2021/03/23.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject private var viewModel = ContentViewModel()
    @State var shouldShowDebugMenu = false
    var body: some View {
        ZStack {
            VStack {
                if viewModel.colorList.isEmpty {
                    Text("List is empty!")
                        .padding()
                } else {
                    ScrollView(.vertical, showsIndicators: false, content: {
                        ForEach(viewModel.colorList, id: \.id) { model in
                            ZStack {
                                Color(model.color)
                                    .frame(height: 40)
                                Text(model.text)
                                    .lineLimit(1)
                                    .padding()
                            }
                        }
                        Spacer()
                    })
                }
            }
            VStack {
                Spacer()
                Button(action: {
                    viewModel.refreshList()
                }, label: {
                    Text("Refresh")
                        .frame(width: 200, height: 60)
                        .background(Color.white)
                        .clipped()
                        .cornerRadius(30)
                })
                .frame(width: 200, height: 60)
                .padding(.bottom, 20)
            }
        }
        .alert(item: $viewModel.errorMessage, content: { errorMessage -> Alert in
            Alert(title: Text("Error"), message: Text(errorMessage.message
            ), dismissButton: .default(Text("OK")))
        })
        .ignoresSafeArea(edges: [.bottom, .horizontal])
        .onAppear(perform: {
            viewModel.refreshList()
        })
        .onReceive(NotificationCenter.default.publisher(for: UIDevice.deviceDidShakeNotification), perform: { _ in
            self.shouldShowDebugMenu.toggle()
        })
        .presentDebugMenu(shouldShow: $shouldShowDebugMenu)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
