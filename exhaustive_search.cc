int exhaustive_search(int* a, int size, int key)
{
    int index = -1;
    for (int i = 0; i < size; i++)
        if (a[i] == key)
        {
            index = i;
            break;
        }
    return index;
}

int main()
{
    int a[10] = {4, 5, 2, 2, 5, 9, 1, 0, -9, 3};
    int key = 3;
    int index = exhaustive_search(a, 10, key);
    bool is_key_found = (index > -1) ? true : false;   
    return 0;
}