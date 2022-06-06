using Microsoft.Extensions.Caching.Distributed;
using Newtonsoft.Json;
using TadeuStore.Domain.Interfaces;

namespace TadeuStore.Infra.Data.Cache
{
    public class CacheConnection : ICacheConnection
    {
        private readonly IDistributedCache _cache;
        public CacheConnection(
            IDistributedCache cache)
        {
            _cache = cache;
        }

        public async Task SetAsync<T>(string key, T value, TimeSpan expiry)
        {
            DistributedCacheEntryOptions entryOptions = new DistributedCacheEntryOptions()
            {
                AbsoluteExpiration = new DateTimeOffset(DateTime.Now.Add(expiry))
            };

            await _cache.SetStringAsync(key, JsonConvert.SerializeObject(value), entryOptions);
        }

        public async Task<T> GetAsync<T>(string key)
        {
            var data = await _cache.GetStringAsync(key);

            if (data == null)
                return default(T);

            return JsonConvert.DeserializeObject<T>(data);
        }

        public byte[] Get(string key)
        {
            return _cache.Get(key);
        }

        public Task<byte[]> GetAsync(string key, CancellationToken token = default)
        {
            return _cache.GetAsync(key, token);
        }

        public void Refresh(string key)
        {
            _cache.Refresh(key);
        }

        public Task RefreshAsync(string key, CancellationToken token = default)
        {
            return _cache.RefreshAsync(key, token);
        }

        public void Remove(string key)
        {
            _cache.Remove(key);
        }

        public Task RemoveAsync(string key, CancellationToken token = default)
        {
            return _cache.RemoveAsync(key, token);
        }

        public void Set(string key, byte[] value, DistributedCacheEntryOptions options)
        {
            _cache.Set(key, value, options);
        }

        public Task SetAsync(string key, byte[] value, DistributedCacheEntryOptions options, CancellationToken token = default)
        {
            return _cache.SetAsync(key, value, options, token);
        }
    }
}
