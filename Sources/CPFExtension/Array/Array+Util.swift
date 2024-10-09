//
//  Array+Util.swift
//  CPFExtensions
//
//  Created by Aaron on 2018/3/28.
//  Copyright © 2018年 ruhnn. All rights reserved.
//

import Foundation
import CPFChain

/// 数组通用协议
/// 在Cpf中针对Array进行类型约束比较困难，使用次协议进行约束
public protocol AnyCpfArray {
    associatedtype Element
    var cpfArray: Array<Element> { get }
}

extension Array: AnyCpfArray {
    public var cpfArray: Array<Element> { self }
    
}

extension Array: @retroactive CpfCompatible {}

public extension Cpf where Wrapped: AnyCpfArray {
    /// 返回数组指定索引的元素，不存在时返回nil
    /// 注意：正常情况下，应通过数据下标来访问指定元素，出现错误也容易及时发现
    func element(at index: Int) -> Wrapped.Element? {
        wrapped.cpfArray.cpfElement(at: index)
    }
}

public extension Cpf where Wrapped: AnyCpfArray, Wrapped.Element: Equatable {
    /// 忽略顺序，比较2个数组中数据是否相同
    /// - Parameter anotherArray: 待比较的另一个数组
    func isSameValue(with anotherArray: [Wrapped.Element]) -> Bool {
        wrapped.cpfArray.cpfIsSameValue(with: anotherArray)
    }
}

public extension Array {
    /// 返回数组指定索引的元素，不存在时返回nil
    /// 注意：正常情况下，应通过数据下标来访问指定元素，出现错误也容易及时发现
    func cpfElement(at index: Int) -> Element? {
        guard (startIndex..<endIndex).contains(index) else { return nil }
        return self[index]
    }

    /// 安全删除数组指定索引元素，索引异常时返回nil
    @discardableResult
    mutating func cpfRemove(at index: Int) -> Element? {
        guard (startIndex..<endIndex).contains(index) else {
            assert(false, "数据元素访问越界")
            return nil
        }
        return remove(at: index)
    }
}


public extension Array where Element: Equatable {
    /// 移除第一个指定元素
    mutating func cpfRemoveFirst(_ element: Element) {
        guard let index = firstIndex(of: element) else { return }
        cpfRemove(at: index)
    }
    
    /// 移除全部指定元素
    mutating func cpfRemoveAll(_ element: Element) {
        removeAll(where: { $0 == element })
    }
}

public extension Array where Element: Equatable {
    /// 移除重复元素
    func cpfRemoveDumplicatedElements() -> [Element] {
        var newList = [Element]()
        for aElement in self {
            if !newList.contains(aElement) {
                newList.append(aElement)
            }
        }
        return newList
    }
    
    /// 忽略顺序，比较2个数组中数据是否相同
    /// - Parameter anotherArray: 待比较的另一个数组
    func cpfIsSameValue(with anotherArray: [Element]) -> Bool {
        guard self.count == anotherArray.count else { return false }
        let list = cpfRemoveDumplicatedElements()
        let anotherList = anotherArray.cpfRemoveDumplicatedElements()
        guard list.count == anotherList.count else { return false }
        return list.allSatisfy({ anotherList.contains($0) }) && anotherList.allSatisfy({ list.contains($0) })
    }
}
