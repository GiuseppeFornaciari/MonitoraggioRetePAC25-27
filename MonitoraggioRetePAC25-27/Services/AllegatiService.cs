using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Options;
using MonitoraggioRetePAC25_27.Data;
using MonitoraggioRetePAC25_27.Models;
using MonitoraggioRetePAC25_27.Utilities;

namespace MonitoraggioRetePAC25_27.Services
{
    public class AllegatiService
    {
        private readonly IWebHostEnvironment _env;
        private readonly MonitoraggioRetePAC2527Context _context;
        private readonly string _basePath;

        public AllegatiService(
                  IWebHostEnvironment env,
                  MonitoraggioRetePAC2527Context context,
                  IOptions<PercorsiAllegatiOptions> allegatiOptions)
        {
            _env = env;
            _context = context;

            var configuredBasePath = string.IsNullOrWhiteSpace(allegatiOptions.Value.BasePath)
                ? "Uploads"
                : allegatiOptions.Value.BasePath;
            _basePath = Path.IsPathRooted(configuredBasePath)
                ? configuredBasePath
                : Path.Combine(_env.ContentRootPath, configuredBasePath);

            Directory.CreateDirectory(_basePath);
        }

        private string GetAllegatiPath(Output output, bool ensureExists = true)
        {
            if (output?.IdProgettoNavigation?.IdSchedaNavigation == null)
                throw new ArgumentNullException(nameof(output), "Output o dati navigazione mancanti");

            var dataFolder = output.IdProgettoNavigation.IdSchedaNavigation.DataMonitoraggio.ToString("yyyyMMdd");
            var path = Path.Combine(_basePath, dataFolder, output.CodOutputCompleto);

            if (ensureExists && !Directory.Exists(path))
                Directory.CreateDirectory(path);

            return path;
        }

        public Output? GetOutputWithNavigation(int idOutput)
        {
            return _context.Outputs
                .Include(o => o.IdProgettoNavigation)
                .ThenInclude(p => p.IdSchedaNavigation)
                .FirstOrDefault(o => o.IdOutput == idOutput);
        }

        public List<string> GetFileList(Output output)
        {
            var path = GetAllegatiPath(output, false);
            return Directory.Exists(path)
                ? Directory.GetFiles(path).Select(Path.GetFileName).ToList()
                : new List<string>();
        }

        public async Task SaveFileAsync(Output output, IFormFile file)
        {
            var path = GetAllegatiPath(output);
            var filePath = Path.Combine(path, Path.GetFileName(file.FileName));
            using var stream = new FileStream(filePath, FileMode.Create);
            await file.CopyToAsync(stream);
        }

        public byte[]? GetFileContent(Output output, string fileName, out string filePath)
        {
            filePath = Path.Combine(GetAllegatiPath(output, false), fileName);
            return File.Exists(filePath) ? File.ReadAllBytes(filePath) : null;
        }

        public void DeleteFile(Output output, string fileName)
        {
            var path = Path.Combine(GetAllegatiPath(output, false), fileName);
            if (File.Exists(path))
                File.Delete(path);
        }
    }
}
