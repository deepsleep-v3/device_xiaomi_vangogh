import os
import sys
from typing import List, Dict, Any

class BundleTool:
    BEGIN_MARKER = "<<<BUNDLE_BEGIN\n"
    END_MARKER = "<<<BUNDLE_END\n"
    FILE_START_PREFIX = "<<<FILE path="
    FILE_END_MARKER = ">>>END\n"

    @staticmethod
    def pack(target_dir: str, output_file: str) -> None:
        """将目录打包为单文本文件"""
        if not os.path.exists(target_dir):
            print(f"❌ 找不到目录: {target_dir}")
            sys.exit(1)

        out_content: List[str] = [BundleTool.BEGIN_MARKER]
        abs_output = os.path.abspath(output_file)
        file_count = 0

        # os.walk 自动递归遍历多层嵌套目录
        for root, dirs, files in os.walk(target_dir):
            for file in sorted(files):
                full_path = os.path.join(root, file)
                
                # 忽略输出文件自身
                if os.path.abspath(full_path) == abs_output:
                    continue

                # 获取相对路径，并将反斜杠转为正斜杠
                rel_path = os.path.relpath(full_path, os.getcwd()).replace("\\", "/")
                
                out_content.append(f"{BundleTool.FILE_START_PREFIX}{rel_path} codec=text\n")
                
                try:
                    with open(full_path, "r", encoding="utf-8") as f:
                        content = f.read()
                        out_content.append(content)
                        # 确保文件末尾有换行，防止与 >>>END 粘连
                        if not content.endswith("\n"):
                            out_content.append("\n")
                except UnicodeDecodeError:
                    out_content.append("[ERROR: 包含二进制或非UTF-8内容]\n")
                
                out_content.append(BundleTool.FILE_END_MARKER)
                file_count += 1

        out_content.append(BundleTool.END_MARKER)

        # 强制以 UTF-8 无 BOM 写入
        with open(output_file, "w", encoding="utf-8", newline="\n") as f:
            f.writelines(out_content)
            
        print(f"✅ 打包成功！共打包 {file_count} 个文件，保存至: {output_file}")

    @staticmethod
    def unpack(input_file: str, output_dir: str) -> None:
        """从单文本文件解包还原目录"""
        if not os.path.exists(input_file):
            print(f"❌ 找不到文件: {input_file}")
            sys.exit(1)

        with open(input_file, "r", encoding="utf-8") as f:
            lines = f.readlines()

        current_path: str = ""
        current_content: List[str] = []
        file_count = 0
        is_reading_file = False

        for line in lines:
            if line.startswith(BundleTool.FILE_START_PREFIX):
                # 解析 path 和 codec (例如: <<<FILE path=Chinese/options/General.lang codec=text)
                parts = line.strip().split(" ")
                if len(parts) >= 2:
                    current_path = parts[1].replace("path=", "")
                    current_content = []
                    is_reading_file = True
            
            elif line == BundleTool.FILE_END_MARKER.strip() + "\n" and is_reading_file:
                # 遇到 >>>END，写入文件
                dest_path = os.path.join(output_dir, current_path)
                dest_dir = os.path.dirname(dest_path)
                
                # 自动创建多层嵌套目录
                if dest_dir:
                    os.makedirs(dest_dir, exist_ok=True)
                
                with open(dest_path, "w", encoding="utf-8", newline="\n") as out_f:
                    out_f.writelines(current_content)
                
                print(f"  📄 解包: {current_path}")
                is_reading_file = False
                file_count += 1
            
            elif is_reading_file:
                # 收集文件内容
                current_content.append(line)

        print(f"✅ 解包成功！共提取 {file_count} 个文件至: {output_dir}")


# ==========================================
# CLI 调用入口
# ==========================================
if __name__ == "__main__":
    if len(sys.argv) < 2:
        print("用法:")
        print("  python bundle.py pack [目标目录] [输出文件]")
        print("  python bundle.py unpack [输入文件] [输出目录]")
        sys.exit(1)

    command = sys.argv[1]

    if command == "pack":
        target = sys.argv[2] if len(sys.argv) > 2 else "."
        output = sys.argv[3] if len(sys.argv) > 3 else "bundle.txt"
        BundleTool.pack(target, output)
        
    elif command == "unpack":
        if len(sys.argv) < 3:
            print("❌ 请指定要解包的 bundle 文件路径")
            sys.exit(1)
        input_file = sys.argv[2]
        output_dir = sys.argv[3] if len(sys.argv) > 3 else "./unpacked"
        BundleTool.unpack(input_file, output_dir)
        
    else:
        print(f"❌ 未知命令: {command}")