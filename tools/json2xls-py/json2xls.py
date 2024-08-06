import os
import json
import pandas as pd
import argparse

from openpyxl import Workbook
from openpyxl.styles import Font

def get_current_file_directory():
    # 获取当前文件的绝对路径
    current_file_path = os.path.abspath(__file__)
    # 获取当前文件的目录
    current_directory = os.path.dirname(current_file_path)
    return current_directory

def flatten_dict(d, parent_key='', sep='#'):
    """
    展平嵌套字典
    :param d: 要展平的字典
    :param parent_key: 父键名
    :param sep: 分隔符
    :return: 展平后的字典
    """
    items = {}
    for k, v in d.items():
        new_key = f"{parent_key}{sep}{k}" if parent_key else k
        if isinstance(v, dict):
            items.update(flatten_dict(v, new_key, sep=sep))
        else:
            items[new_key] = v
    return items

def flatten_dict_to_array(d):
    """
    展平嵌套字典并将值转换为数组
    :param d: 要展平的字典
    :return: 展平后的字典
    """
    items = {}
    for k, v in d.items():
        if isinstance(v, dict):
            array = []
            for key in v:
                array.append(v[key])
            items[k] = array
        else:
            items[k] = v
    return items


def json_to_excel(input_dir, output_dir):
    # 遍历输入目录下的所有 JSON 文件
    for root, _, files in os.walk(input_dir):
        for file in files:
            if file.endswith('.json'):
                json_file = os.path.join(root, file)
                print("===============>run:",json_file)

                with open(json_file, 'r', encoding='utf-8') as f:
                    json_data = json.load(f)

                excel_name = os.path.splitext(file)[0]
                if (isinstance(json_data, dict) and json_data.keys()):
                    keys = list(json_data.keys())
                    excel_name = keys[0]
                    filter_data = [flatten_dict_to_array(item) for item in json_data[keys[0]]]
                    df = pd.json_normalize(filter_data)


                else:
                    df = pd.json_normalize(json_data)

                # 添加 ID 列
                df.insert(0, 'ID', range(len(df)))
                excel_file = os.path.join(output_dir, f"{excel_name}.xlsx")

                # df.to_excel(excel_file, index=False, sheet_name='Sheet1')
                # 使用 openpyxl 写入 Excel 文件
                # with pd.ExcelWriter(excel_file, engine='openpyxl') as writer:
                #     df.to_excel(writer, index=False, sheet_name='Sheet1')

                #     # 获取当前工作表
                #     worksheet = writer.sheets['Sheet1']

                #     # 设置表头字体为非黑体
                #     for cell in worksheet["1:1"]:  # 第一行是表头
                #         cell.font = Font(name='Arial')  # 或者其他非黑体字体
                # 使用 openpyxl 写入 Excel 文件
                with pd.ExcelWriter(excel_file, engine='openpyxl') as writer:
                    df.to_excel(writer, index=False, sheet_name='Sheet1')

                    # 获取当前工作表
                    worksheet = writer.sheets['Sheet1']

                    # 调整列宽为表头字符的宽度
                    for column in worksheet.columns:
                        max_length = 0
                        column_letter = column[0].column_letter  # 获取列字母

                        for cell in column:
                            try:
                                if len(str(cell.value)) > max_length:
                                    max_length = len(str(cell.value))
                            except:
                                pass

                        adjusted_width = (max_length + 2)  # 加一些间距
                        worksheet.column_dimensions[column_letter].width = adjusted_width
                    for cell in worksheet["1:1"]:  # 第一行是表头
                        cell.font = Font(name='Arial')  # 或者其他非黑体字体

                print(f"===============>success {json_file} convert to {excel_file}")

def main(input_dir, output_dir):
 
    os.makedirs(output_dir, exist_ok=True)
    json_to_excel(input_dir, output_dir)

if __name__ == "__main__":
    parser = argparse.ArgumentParser(description='Convert JSON files to Excel.')
    parser.add_argument('input_dir', type=str, help='输入目录路径')
    parser.add_argument('output_dir', type=str, help='输出目录路径')
    
    args = parser.parse_args()
    
    input_dir = args.input_dir
    output_dir = args.output_dir

    if not os.path.exists(input_dir):
        print(f"错误：输入目录 '{input_dir}' 不存在。")
        input_dir = os.path.join(get_current_file_directory(), "input_json")
        print("默认输入目录为",input_dir)

    if not os.path.exists(output_dir):
        print(f"错误：输出目录 '{output_dir}' 不存在。")
        output_dir = os.path.join(get_current_file_directory(), "output_excel")
        print("默认输出目录为",output_dir)
        

    main(input_dir, output_dir)
