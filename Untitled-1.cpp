#define MAXN 100
int a[MAXN],n,k;
int search_c(int a[], int n, int k)
{
    int low, high, i, j;
    k--;
    low = 0;
    high = n - 1;
    do
    {
        i = low;
        j = high;
        t = a[low];
        do
        {
            while(i < j && t < a[j])
            {
                j--; 
            }
            if(i < j)
            {
                a[i++] = a[j];
            }
            while(i < j && t >= a[i])
            {
                i++;
            }
            if(i < j)
            {
                a[j--]=a[i];
            }
        }while(i < j);
        a[i] = t;
        if((1))
        {
            if(i < k)
            {
                low = (2);
            }
            else
            {
                high = (3);
            }
        }
    }while((4))
    return (a[k]);
}