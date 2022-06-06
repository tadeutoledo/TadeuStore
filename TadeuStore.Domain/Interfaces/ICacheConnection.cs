using Microsoft.Extensions.Caching.Distributed;

namespace TadeuStore.Domain.Interfaces
{
    public interface ICacheConnection : IDistributedCache
    {
        Task SetAsync<T>(string key, T value, TimeSpan expiry);
        Task<T> GetAsync<T>(string key);
    }
}
