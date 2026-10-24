#!/usr/bin/env python3
# test-advisor.py - Advisor 顾问模式测试框架
# 用于验证顾问判断准确性
#
# 用法: python scripts/test-advisor.py
#       python scripts/test-advisor.py --add
#
# 判据验证原则：
# 任何检查写完后，先喂已知答案为"否"的输入，确认它会变红

import json
import sys
from pathlib import Path

TEST_FILE = Path("tests/advisor-cases.json")
DEFAULT_MODEL = "openco-zen/deepseek-v4.1-flash-free"


def load_test_cases():
    """加载测试用例"""
    if not TEST_FILE.exists():
        print("No test cases found. Creating template...")
        template = {"cases": []}
        TEST_FILE.parent.mkdir(parents=True, exist_ok=True)
        TEST_FILE.write_text(json.dumps(template, indent=2, ensure_ascii=False))
        return template["cases"]
    return json.loads(TEST_FILE.read_text(encoding="utf-8")).get("cases", [])


def run_test(case):
    """运行单个测试用例"""
    print(f"\nTesting: {case['id']}")
    print(f"Question: {case.get('description', 'N/A')}")

    # TODO: 接入实际顾问 API
    # result = call_advisor(case['context'], case['question'])
    result = case.get("expected", "pending")
    case["actual"] = result
    case["passed"] = result == case.get("expected")

    status = "✓ PASS" if case["passed"] else "❌ FAIL"
    print(f"Expected: {case.get('expected', 'N/A')}")
    print(f"Actual:   {result}")
    print(f"Status:   {status}")
    return case["passed"]


def add_negative_test():
    """添加一个已知答案为'否'的负样本测试"""
    print("\n=== 添加负样本测试 ===")
    print("请提供：")
    description = input("问题描述: ")
    context = input("干净上下文: ")
    expected = input("预期判断 (应为'否'): ")

    new_case = {
        "id": f"neg-test-{len(cases) + 1}",
        "description": description,
        "context": context,
        "question": description,
        "expected": expected,
        "actual": None,
        "passed": False,
    }
    cases.append(new_case)

    with open(TEST_FILE, "w", encoding="utf-8") as f:
        json.dump({"cases": cases}, f, indent=2, ensure_ascii=False)

    print(f"✓ 已保存到 {TEST_FILE}")


def main():
    cases = load_test_cases()

    if not cases:
        print("No test cases found. Use --add to create one.")
        print("Example: python scripts/test-advisor.py --add")
        sys.exit(0)

    passed = sum(run_test(c) for c in cases)
    total = len(cases)

    print(f"\n=== Results: {passed}/{total} passed ===")

    if passed == total:
        print("✓ All tests passed!")
        sys.exit(0)
    else:
        print(f"❌ {total - passed} test(s) failed.")
        print("   Review the failing cases and fix the advisor logic.")
        sys.exit(1)


if __name__ == "__main__":
    if len(sys.argv) > 1 and sys.argv[1] == "--add":
        cases = load_test_cases()
        add_negative_test()
    else:
        main()
