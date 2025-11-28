using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Identity.UI.Services;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.DependencyInjection;
using MonitoraggioPAC25_27.Data;
using MonitoraggioPAC25_27.Models;
using MonitoraggioPAC25_27.Services;
using MonitoraggioPAC25_27.Utilities;


var builder = WebApplication.CreateBuilder(args);

// Add services to the container.
var connectionString = builder.Configuration.GetConnectionString("DefaultConnection") ?? 
    throw new InvalidOperationException("Connection string 'DefaultConnection' not found.");
builder.Services.AddDbContext<ApplicationDbContext>(options =>
    options.UseSqlServer(connectionString));
builder.Services.AddDbContext<MonitoraggioPAC2527Context>(options =>
    options.UseSqlServer(connectionString));
builder.Services.AddDatabaseDeveloperPageExceptionFilter();

builder.Services.Configure<PercorsiAllegatiOptions>(
    builder.Configuration.GetSection("PercorsiAllegati"));

builder.Services.AddDefaultIdentity<IdentityUser>(options => 
        options.SignIn.RequireConfirmedAccount = true) 
    .AddRoles<IdentityRole>()  // Aggiunto supporto per i ruoli
    .AddEntityFrameworkStores<ApplicationDbContext>();
builder.Services.AddControllersWithViews();

//servizio per recuperare ruolo utente
builder.Services.AddSingleton<IHttpContextAccessor, HttpContextAccessor>();
builder.Services.AddTransient<RoleService>();
builder.Services.AddScoped<AllegatiUtility>();

// servizio personalizzato UTENTE
builder.Services.AddScoped<UtenteService>();
// servizio per gestire gli allegati
builder.Services.AddScoped<AllegatiService>();
//EMAIL
builder.Services.AddTransient<IEmailSender, SmtpEmailSender>();
builder.Services.Configure<SmtpSettings>(builder.Configuration.GetSection("Smtp"));

var app = builder.Build();

//// Esegui il seeding degli utenti all'avvio
//using (var scope = app.Services.CreateScope())
//{
//    var services = scope.ServiceProvider;
//    var csvPath = Path.Combine(Directory.GetCurrentDirectory(), "ElencoUtenti.csv");

//    await UserSeeder.SeedFromCsvAsync(services, csvPath);
//}

// Configure the HTTP request pipeline.
if (app.Environment.IsDevelopment())
{
    app.UseMigrationsEndPoint();
}
else
{
    app.UseExceptionHandler("/Home/Error");
    // The default HSTS value is 30 days. You may want to change this for production scenarios, see https://aka.ms/aspnetcore-hsts.
    app.UseHsts();
}

app.UseHttpsRedirection();
app.UseRouting();
app.UseAuthentication();   // ← OBBLIGATORIO prima dell'autorizzazione
app.UseAuthorization();

app.MapStaticAssets();

app.MapControllerRoute(
    name: "default",
    pattern: "{controller=Home}/{action=Index}/{id?}")
    .WithStaticAssets();

app.MapRazorPages()
   .WithStaticAssets();

app.Run();
