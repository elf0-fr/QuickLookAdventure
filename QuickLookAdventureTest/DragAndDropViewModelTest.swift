//
//  DragAndDropViewModelTest.swift
//  QuickLookAdventure
//
//  Created by Elfo on 01/12/2024.
//

import Testing
#if os(macOS)
@testable import QuickLookAdventure_macOS
#elseif os(iOS)
@testable import QuickLookAdventure_iOS
#endif

@MainActor
@Suite("Drag & Drop ViewModel")
struct DragAndDropViewModelTest {
    @MainActor
    struct Initiate {
        @Test("Given zero resource when initiate then empty")
        func zeroResource_Initiate_Empty() throws {
            let viewModel = DragAndDropViewModel(resources: [])
            #expect(viewModel.resources.isEmpty)
        }
        
        @Test("Given 1 resource when initiate then 1")
        func oneResource_Initiate_1() throws {
            let viewModel = DragAndDropViewModel(
                resources: [Resource.sampleImage]
            )
            #expect(viewModel.resources.count == 1)
        }
        
        @Test("Given 2 resources when initiate then 2")
        func twoResources_Initiate_2() throws {
            let viewModel = DragAndDropViewModel(
                resources: [Resource.sampleImage, Resource.samplePDF]
            )
            #expect(viewModel.resources.count == 2)
        }
    }

    @MainActor
    struct Remove {
        @Test("Given 1 resource when remove then empty")
        func oneResource_Remove_Empty() throws {
            let resource = Resource.sampleImage
            let viewModel = DragAndDropViewModel(resources: [resource])
            
            viewModel.remove(resource: resource)
            
            #expect(viewModel.resources.isEmpty)
        }
        
        @Test(
            "Given 3 resources when remove one then 2 remains",
            arguments: 0..<3
        )
        func threeResources_Remove_2Remains(indexToRemove: Int) throws {
            let resources = [
                Resource.sampleImage,
                Resource.samplePDF,
                Resource.sampleText
            ]
            let viewModel = DragAndDropViewModel(
                resources: resources
            )
            
            viewModel.remove(resource: resources[indexToRemove])
            
            #expect(viewModel.resources.count == 2)
            #expect(!viewModel.resources.contains(resources[indexToRemove]))
        }
    }
    
    @MainActor
    struct DropAction {
        @Test(
            "Given 1 resource and matching fileType when drop then remove resource",
            arguments: zip(
                [Resource.samplePDF, Resource.sampleText, Resource.sampleImage, Resource.sampleVideo],
                [FileType.pdf, FileType.text, FileType.image, FileType.video]
            )
        )
        func resourceAndMatchingType_Drop_remove(
            resource: Resource,
            fileType: FileType
        ) {
            let resources = [
                resource
            ]
            let viewModel = DragAndDropViewModel(
                resources: resources
            )
            
            let result = viewModel.dropAction(resources: [resource], fileType: fileType) {
                
            }
            
            #expect(result)
            #expect(!viewModel.resources.contains(resource))
        }
        
        @Test(
            "Given 1 resource and mismatched fileType when drop then fail. Part1",
            arguments: [Resource.samplePDF, Resource.sampleText],
            [FileType.image, FileType.video]
        )
        func resourceAndMismatchedType_Drop_Fail_Part1(
            resource: Resource,
            fileType: FileType
        ) {
            let resources = [
                resource
            ]
            let viewModel = DragAndDropViewModel(
                resources: resources
            )
            
            let result = viewModel.dropAction(resources: [resource], fileType: fileType) {
                #expect(true)
            }
            
            #expect(!result)
            #expect(viewModel.resources.contains(resource))
        }
        
        @Test(
            "Given 1 resource and mismatched fileType when drop then fail. Part2",
            arguments: [Resource.sampleImage, Resource.sampleVideo],
            [FileType.pdf, FileType.text]
        )
        func resourceAndMismatchedType_Drop_Fail_Part2(
            resource: Resource,
            fileType: FileType
        ) {
            let resources = [
                resource
            ]
            let viewModel = DragAndDropViewModel(
                resources: resources
            )
            
            let result = viewModel.dropAction(resources: [resource], fileType: fileType) {
                #expect(true)
            }
            
            #expect(!result)
            #expect(viewModel.resources.contains(resource))
        }
    }
    
    @MainActor
    struct IsGameOver {
        @Test("Given 0 resource when call gameOver then return true")
        func zeroResource_GameOver_True() {
            let viewModel = DragAndDropViewModel(resources: [])
            #expect(viewModel.isGameOver)
        }
        
        @Test("Given 1 resource when call gameOver then return false")
        func oneResource_GameOver_False() {
            let viewModel = DragAndDropViewModel(resources: [Resource.sampleImage])
            #expect(!viewModel.isGameOver)
        }
    }
}
