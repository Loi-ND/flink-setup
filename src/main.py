from pyflink.datastream import StreamExecutionEnvironment
from pyflink.common.typeinfo import Types

def multiply_by_two(x):
    return x * 2

def main():
    # 1. Tạo execution environment
    env = StreamExecutionEnvironment.get_execution_environment()

    # 2. Tạo nguồn dữ liệu (1..10)
    numbers = env.from_collection(
        collection=[1,2,3,4,5,6,7,8,9,10],
        type_info=Types.INT()
    )

    # 3. Map operator: nhân đôi
    doubled = numbers.map(multiply_by_two, output_type=Types.INT())

    # 4. Sink: in ra stdout
    doubled.print()

    # 5. Thực thi job
    env.execute("Multiply Numbers by Two")

if __name__ == "__main__":
    main()
