import os

def rename_files(folder_path):
    # 获取文件夹中的所有文件名
    file_list = os.listdir(folder_path)
    
    for file_name in file_list:
        # 拆分文件名和序号
        parts = file_name.split('-')
        name = parts[0]
        numbers = '-'.join(parts[1:]).split('.')
        number = numbers[0]
        suffix = numbers[1]
        
        # 构建新的文件名
        new_file_name = f"{number}-{name}.{suffix}"
        
        # 检查新文件名是否已存在，如果存在，则在序号后面添加一个唯一的数字
        counter = 1
        while os.path.exists(os.path.join(folder_path, new_file_name)):
            new_file_name = f"{number}-{name}-{counter}.{suffix}"
            counter += 1
        
        # 重命名文件
        old_file_path = os.path.join(folder_path, file_name)
        new_file_path = os.path.join(folder_path, new_file_name)
        os.rename(old_file_path, new_file_path)
        
        print(f"重命名文件：{file_name} -> {new_file_name}")

# 指定文件夹路径
folder_path = "D:\pythonobj\demo"

# 调用函数进行重命名
rename_files(folder_path)

