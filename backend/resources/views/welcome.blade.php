<!DOCTYPE html>
<html lang="en" dir="ltr">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Asif Groceries — Fresh Groceries Delivered to Your Door in Lahore</title>
    <meta name="description" content="Order fresh produce, daily essentials, and groceries online. Fast delivery across Lahore. Download the Asif Groceries app today.">
    <meta name="theme-color" content="#F15722">
    <link rel="canonical" href="https://asifgroceries.pk">
    <meta property="og:title" content="Asif Groceries — Fresh Groceries Delivered">
    <meta property="og:description" content="Order fresh produce & daily essentials. Fast delivery across Lahore.">
    <meta property="og:type" content="website">
    <meta property="og:url" content="https://asifgroceries.pk">
    <meta property="og:image" content="{{ asset('images/logo.png') }}">

    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700;800&display=swap" rel="stylesheet">

    <style>
        *, *::before, *::after { box-sizing: border-box; margin: 0; padding: 0; }
        html { scroll-behavior: smooth; }
        body {
            font-family: 'Plus Jakarta Sans', -apple-system, BlinkMacSystemFont, sans-serif;
            color: #1a1a1a; background: #fefcfa; line-height: 1.6;
            overflow-x: hidden; -webkit-font-smoothing: antialiased;
        }
        img { display: block; max-width: 100%; }
        a { text-decoration: none; color: inherit; }
        :root {
            --orange: #F15722; --orange-dark: #E8471C; --orange-light: #FF7A47;
            --orange-glow: rgba(241, 87, 34, 0.10); --orange-soft: rgba(241, 87, 34, 0.06);
            --warm-white: #FFFBF7; --warm-gray: #f5f0eb;
            --text-primary: #1a1a1a; --text-secondary: #6b6459; --text-light: #9a9187;
        }

        /* ─── Nav ─── */
        .nav {
            position: fixed; top: 0; left: 0; right: 0; z-index: 100;
            padding: 0.8rem 2rem;
            transition: all 0.4s cubic-bezier(0.16, 1, 0.3, 1);
        }
        .nav.scrolled {
            background: rgba(255, 251, 247, 0.95);
            backdrop-filter: blur(24px); -webkit-backdrop-filter: blur(24px);
            box-shadow: 0 1px 0 rgba(0,0,0,0.06);
        }
        .nav-inner {
            max-width: 1200px; margin: 0 auto;
            display: flex; align-items: center; justify-content: space-between;
        }
        .nav-logo { display: flex; align-items: center; gap: 0.75rem; }
        .nav-logo img { width: 46px; height: 46px; border-radius: 12px; }
        .nav-logo-text { font-weight: 800; font-size: 1.3rem; color: var(--text-primary); }
        .nav-links { display: flex; align-items: center; gap: 2.2rem; list-style: none; }
        .nav-links a { font-size: 0.9rem; font-weight: 500; color: var(--text-secondary); transition: color 0.2s; }
        .nav-links a:hover { color: var(--orange); }
        .nav-cta {
            background: var(--orange); color: white !important;
            padding: 0.6rem 1.6rem; border-radius: 50px;
            font-weight: 600; font-size: 0.9rem; transition: all 0.3s;
            box-shadow: 0 2px 12px var(--orange-glow);
        }
        .nav-cta:hover { background: var(--orange-dark); transform: translateY(-1px); box-shadow: 0 4px 20px rgba(241,87,34,0.3); }
        .mobile-menu-btn { display: none; background: none; border: none; cursor: pointer; padding: 0.5rem; }
        .mobile-menu-btn span { display: block; width: 22px; height: 2px; background: var(--text-primary); margin: 5px 0; border-radius: 2px; }

        /* ─── Hero ─── */
        .hero {
            min-height: 100vh; display: flex; align-items: center;
            position: relative; overflow: hidden;
            background: linear-gradient(165deg, #fff 0%, var(--warm-white) 50%, var(--warm-gray) 100%);
        }
        .hero::after {
            content: ''; position: absolute;
            top: -20%; right: -10%; width: 800px; height: 800px;
            background: radial-gradient(circle, rgba(241,87,34,0.08) 0%, transparent 65%);
            border-radius: 50%; pointer-events: none;
        }
        .hero::before {
            content: ''; position: absolute;
            bottom: -15%; left: -5%; width: 500px; height: 500px;
            background: radial-gradient(circle, rgba(241,87,34,0.04) 0%, transparent 65%);
            border-radius: 50%; pointer-events: none;
        }
        .hero-inner {
            max-width: 1200px; margin: 0 auto; padding: 9rem 2rem 5rem;
            display: grid; grid-template-columns: 1fr 1fr; gap: 4rem;
            align-items: center; position: relative; z-index: 1;
        }
        .hero-badge {
            display: inline-flex; align-items: center; gap: 0.5rem;
            background: var(--orange-glow); color: var(--orange-dark);
            padding: 0.45rem 1.1rem; border-radius: 50px;
            font-size: 0.82rem; font-weight: 600; margin-bottom: 1.5rem;
            animation: fadeInUp 0.7s ease both;
        }
        .hero-badge-dot { width: 7px; height: 7px; background: var(--orange); border-radius: 50%; animation: pulse-dot 2s infinite; }
        .hero h1 {
            font-size: clamp(2.6rem, 5.2vw, 4rem); font-weight: 800;
            line-height: 1.08; letter-spacing: -0.035em; color: var(--text-primary);
            margin-bottom: 1.3rem; animation: fadeInUp 0.7s ease 0.08s both;
        }
        .hero h1 span {
            background: linear-gradient(135deg, var(--orange) 0%, var(--orange-light) 100%);
            -webkit-background-clip: text; -webkit-text-fill-color: transparent; background-clip: text;
        }
        .hero-subtitle {
            font-size: 1.15rem; color: var(--text-secondary);
            max-width: 460px; line-height: 1.75; margin-bottom: 2.5rem;
            animation: fadeInUp 0.7s ease 0.16s both;
        }
        .hero-actions { display: flex; align-items: center; gap: 1rem; animation: fadeInUp 0.7s ease 0.24s both; flex-wrap: wrap; }
        .btn-primary {
            display: inline-flex; align-items: center; gap: 0.6rem;
            background: var(--orange); color: white;
            padding: 0.95rem 2.2rem; border-radius: 14px;
            font-weight: 700; font-size: 1rem;
            transition: all 0.3s cubic-bezier(0.16, 1, 0.3, 1);
            box-shadow: 0 4px 24px rgba(241,87,34,0.3), inset 0 1px 0 rgba(255,255,255,0.15);
            border: none; cursor: pointer;
        }
        .btn-primary:hover { background: var(--orange-dark); transform: translateY(-2px); box-shadow: 0 8px 32px rgba(241,87,34,0.35); }
        .btn-primary svg { width: 18px; height: 18px; }
        .btn-secondary {
            display: inline-flex; align-items: center; gap: 0.5rem;
            color: var(--text-primary); padding: 0.95rem 1.8rem;
            border-radius: 14px; font-weight: 600; font-size: 1rem;
            border: 1.5px solid rgba(0,0,0,0.08); background: white;
            transition: all 0.3s; cursor: pointer;
        }
        .btn-secondary:hover { border-color: var(--orange); color: var(--orange); background: var(--orange-soft); }

        /* ─── Phone — clean, no dark border ─── */
        .hero-visual {
            display: flex; justify-content: center; position: relative;
            animation: fadeInUp 0.8s ease 0.32s both;
        }
        .phone-device { position: relative; width: 290px; }
        .phone-frame {
            border-radius: 36px;
            overflow: hidden;
            box-shadow:
                0 40px 80px rgba(0,0,0,0.10),
                0 16px 32px rgba(0,0,0,0.06),
                0 0 0 1px rgba(0,0,0,0.04);
            transform: perspective(900px) rotateY(-5deg) rotateX(2deg);
            transition: transform 0.6s cubic-bezier(0.16, 1, 0.3, 1);
        }
        .phone-frame:hover { transform: perspective(900px) rotateY(-1deg) rotateX(0.5deg); }
        .phone-frame img { width: 100%; height: auto; display: block; }

        .float-badge {
            position: absolute; background: white; border-radius: 16px;
            padding: 0.65rem 1rem;
            box-shadow: 0 8px 28px rgba(0,0,0,0.07), 0 2px 6px rgba(0,0,0,0.03);
            display: flex; align-items: center; gap: 0.55rem;
            font-size: 0.78rem; font-weight: 600; z-index: 3;
            animation: float 5s ease-in-out infinite;
        }
        .float-badge.tl { top: 6%; left: -14%; animation-delay: 0s; }
        .float-badge.br { bottom: 10%; right: -16%; animation-delay: 2.5s; }
        .float-badge-icon {
            width: 34px; height: 34px; border-radius: 10px;
            display: flex; align-items: center; justify-content: center; font-size: 1rem;
        }
        .fb-green { background: #e8f5e9; }
        .fb-blue { background: #e3f2fd; }

        /* ─── Trusted / Stats ─── */
        .stats-bar {
            padding: 4rem 2rem;
            background: white;
            border-top: 1px solid rgba(0,0,0,0.04);
            border-bottom: 1px solid rgba(0,0,0,0.04);
        }
        .stats-inner {
            max-width: 1000px; margin: 0 auto;
            display: grid; grid-template-columns: repeat(4, 1fr); gap: 2rem;
            text-align: center;
        }
        .stat-item {}
        .stat-number { font-size: 2.2rem; font-weight: 800; color: var(--orange); line-height: 1; margin-bottom: 0.3rem; }
        .stat-label { font-size: 0.85rem; color: var(--text-secondary); font-weight: 500; }

        /* ─── Shared section styles ─── */
        .section-inner { max-width: 1200px; margin: 0 auto; }
        .section-label {
            display: inline-block; font-size: 0.78rem; font-weight: 700;
            text-transform: uppercase; letter-spacing: 0.1em;
            color: var(--orange); margin-bottom: 0.75rem;
        }
        .section-title {
            font-size: clamp(1.8rem, 3.5vw, 2.6rem); font-weight: 800;
            letter-spacing: -0.025em; line-height: 1.15; color: var(--text-primary);
            margin-bottom: 1rem;
        }
        .section-desc {
            font-size: 1.05rem; color: var(--text-secondary);
            max-width: 540px; line-height: 1.7; margin-bottom: 3.5rem;
        }

        /* ─── Features ─── */
        .features { padding: 6rem 2rem; background: var(--warm-white); }
        .features-grid { display: grid; grid-template-columns: repeat(3, 1fr); gap: 1.5rem; }
        .feature-card {
            padding: 2rem 1.75rem; border-radius: 20px;
            border: 1px solid rgba(0,0,0,0.04); background: white;
            transition: all 0.4s cubic-bezier(0.16, 1, 0.3, 1);
        }
        .feature-card:hover {
            transform: translateY(-4px);
            box-shadow: 0 16px 48px rgba(0,0,0,0.06);
            border-color: rgba(241,87,34,0.12);
        }
        .feature-icon {
            width: 52px; height: 52px; background: var(--orange-glow);
            border-radius: 14px; display: flex; align-items: center;
            justify-content: center; font-size: 1.4rem; margin-bottom: 1.2rem;
        }
        .feature-card h3 { font-size: 1.05rem; font-weight: 700; margin-bottom: 0.45rem; }
        .feature-card p { font-size: 0.88rem; color: var(--text-secondary); line-height: 1.65; }

        /* ─── How it works ─── */
        .how-it-works { padding: 6rem 2rem; background: white; }
        .steps-row {
            display: grid; grid-template-columns: repeat(3, 1fr); gap: 2rem;
            margin-top: 3.5rem; position: relative;
        }
        /* Connector line */
        .steps-row::before {
            content: ''; position: absolute;
            top: 32px; left: calc(16.66% + 28px); right: calc(16.66% + 28px);
            height: 2px; background: linear-gradient(90deg, var(--orange-glow), var(--orange), var(--orange-glow));
            border-radius: 2px; z-index: 0;
        }
        .step { text-align: center; position: relative; z-index: 1; }
        .step-number {
            width: 60px; height: 60px; background: var(--orange); color: white;
            border-radius: 50%; display: flex; align-items: center; justify-content: center;
            font-size: 1.35rem; font-weight: 800; margin: 0 auto 1.25rem;
            box-shadow: 0 4px 20px rgba(241,87,34,0.25);
            border: 4px solid white;
        }
        .step h3 { font-size: 1.1rem; font-weight: 700; margin-bottom: 0.5rem; }
        .step p { font-size: 0.9rem; color: var(--text-secondary); line-height: 1.6; max-width: 280px; margin: 0 auto; }

        /* ─── Categories preview ─── */
        .categories-section { padding: 6rem 2rem; background: var(--warm-white); }
        .categories-grid {
            display: grid; grid-template-columns: repeat(6, 1fr); gap: 1.25rem;
            margin-top: 2.5rem;
        }
        .cat-card {
            background: white; border-radius: 18px; padding: 1.5rem 1rem;
            text-align: center; border: 1px solid rgba(0,0,0,0.04);
            transition: all 0.3s cubic-bezier(0.16, 1, 0.3, 1);
            cursor: default;
        }
        .cat-card:hover {
            transform: translateY(-3px);
            box-shadow: 0 12px 32px rgba(0,0,0,0.06);
            border-color: rgba(241,87,34,0.12);
        }
        .cat-emoji { font-size: 2.2rem; margin-bottom: 0.6rem; }
        .cat-name { font-size: 0.85rem; font-weight: 600; color: var(--text-primary); }

        /* ─── App showcase / Why download ─── */
        .app-showcase {
            padding: 6rem 2rem; background: white; overflow: hidden;
        }
        .app-showcase-inner {
            max-width: 1200px; margin: 0 auto;
            display: grid; grid-template-columns: 1fr 1fr; gap: 5rem;
            align-items: center;
        }
        .app-showcase-visual { text-align: center; }
        .app-showcase-visual img {
            width: 260px; margin: 0 auto;
            border-radius: 28px;
            box-shadow: 0 32px 64px rgba(0,0,0,0.10), 0 0 0 1px rgba(0,0,0,0.03);
        }
        .checklist { list-style: none; margin-top: 2rem; }
        .checklist li {
            display: flex; align-items: flex-start; gap: 0.8rem;
            padding: 0.75rem 0; font-size: 1rem; color: var(--text-primary);
        }
        .checklist li + li { border-top: 1px solid rgba(0,0,0,0.04); }
        .check-icon {
            width: 26px; height: 26px; min-width: 26px;
            background: var(--orange-glow); border-radius: 50%;
            display: flex; align-items: center; justify-content: center;
            color: var(--orange); font-size: 0.8rem; font-weight: 700; margin-top: 2px;
        }

        /* ─── Testimonials ─── */
        .testimonials { padding: 6rem 2rem; background: var(--warm-white); }
        .testimonials-grid {
            display: grid; grid-template-columns: repeat(3, 1fr); gap: 1.5rem;
            margin-top: 3rem;
        }
        .testimonial-card {
            background: white; border-radius: 20px; padding: 2rem;
            border: 1px solid rgba(0,0,0,0.04);
        }
        .testimonial-stars { color: #F59E0B; font-size: 1rem; margin-bottom: 0.75rem; letter-spacing: 2px; }
        .testimonial-text { font-size: 0.92rem; color: var(--text-secondary); line-height: 1.65; margin-bottom: 1.25rem; font-style: italic; }
        .testimonial-author { font-size: 0.85rem; font-weight: 700; color: var(--text-primary); }
        .testimonial-location { font-size: 0.78rem; color: var(--text-light); }

        /* ─── CTA ─── */
        .cta-section {
            padding: 6rem 2rem;
            background: linear-gradient(135deg, var(--orange) 0%, var(--orange-dark) 100%);
            text-align: center; position: relative; overflow: hidden;
        }
        .cta-section::before {
            content: ''; position: absolute; inset: 0;
            background-image: url("data:image/svg+xml,%3Csvg width='60' height='60' viewBox='0 0 60 60' xmlns='http://www.w3.org/2000/svg'%3E%3Cg fill='none'%3E%3Cg fill='%23ffffff' fill-opacity='0.06'%3E%3Cpath d='M36 34v-4h-2v4h-4v2h4v4h2v-4h4v-2h-4zm0-30V0h-2v4h-4v2h4v4h2V6h4V4h-4zM6 34v-4H4v4H0v2h4v4h2v-4h4v-2H6zM6 4V0H4v4H0v2h4v4h2V6h4V4H6z'/%3E%3C/g%3E%3C/g%3E%3C/svg%3E");
            pointer-events: none;
        }
        .cta-logo { width: 72px; height: 72px; border-radius: 18px; margin: 0 auto 1.5rem; box-shadow: 0 8px 24px rgba(0,0,0,0.15); }
        .cta-section h2 {
            font-size: clamp(2rem, 4vw, 2.8rem); font-weight: 800;
            color: white; margin-bottom: 0.75rem; letter-spacing: -0.02em; position: relative;
        }
        .cta-section p {
            font-size: 1.1rem; color: rgba(255,255,255,0.85);
            margin-bottom: 2.5rem; max-width: 480px; margin-left: auto; margin-right: auto;
            position: relative;
        }
        .cta-buttons { display: flex; justify-content: center; gap: 1rem; position: relative; }
        .btn-white {
            display: inline-flex; align-items: center; gap: 0.6rem;
            background: white; color: var(--orange);
            padding: 0.95rem 2.2rem; border-radius: 14px;
            font-weight: 700; font-size: 1rem;
            transition: all 0.3s; box-shadow: 0 4px 20px rgba(0,0,0,0.1);
            border: none; cursor: pointer;
        }
        .btn-white:hover { transform: translateY(-2px); box-shadow: 0 8px 30px rgba(0,0,0,0.15); }
        .btn-white svg { width: 18px; height: 18px; }
        .btn-outline-white {
            display: inline-flex; align-items: center; gap: 0.5rem;
            background: transparent; color: white;
            padding: 0.95rem 2.2rem; border-radius: 14px;
            font-weight: 600; font-size: 1rem;
            border: 1.5px solid rgba(255,255,255,0.3); transition: all 0.3s; cursor: pointer;
        }
        .btn-outline-white:hover { background: rgba(255,255,255,0.1); border-color: rgba(255,255,255,0.5); }

        /* ─── Footer ─── */
        .footer { padding: 3.5rem 2rem 2rem; background: #1a1a1a; color: rgba(255,255,255,0.55); }
        .footer-inner {
            max-width: 1200px; margin: 0 auto;
            display: flex; align-items: center; justify-content: space-between;
            flex-wrap: wrap; gap: 1.5rem;
        }
        .footer-brand { display: flex; align-items: center; gap: 0.75rem; }
        .footer-brand img { width: 40px; height: 40px; border-radius: 10px; }
        .footer-brand-text { font-weight: 700; color: rgba(255,255,255,0.8); font-size: 1.05rem; }
        .footer-links { display: flex; gap: 2rem; list-style: none; }
        .footer-links a { font-size: 0.85rem; transition: color 0.2s; }
        .footer-links a:hover { color: var(--orange-light); }
        .footer-copy {
            font-size: 0.8rem; width: 100%; text-align: center;
            margin-top: 1.5rem; padding-top: 1.5rem;
            border-top: 1px solid rgba(255,255,255,0.07);
        }

        /* ─── Animations ─── */
        @keyframes fadeInUp { from { opacity: 0; transform: translateY(20px); } to { opacity: 1; transform: translateY(0); } }
        @keyframes float { 0%, 100% { transform: translateY(0); } 50% { transform: translateY(-8px); } }
        @keyframes pulse-dot { 0%, 100% { opacity: 1; } 50% { opacity: 0.4; } }

        /* ─── Scroll reveal ─── */
        .reveal { opacity: 0; transform: translateY(30px); transition: all 0.7s cubic-bezier(0.16, 1, 0.3, 1); }
        .reveal.visible { opacity: 1; transform: translateY(0); }

        /* ─── Responsive ─── */
        @media (max-width: 900px) {
            .hero-inner { grid-template-columns: 1fr; text-align: center; gap: 3rem; padding-top: 7rem; }
            .hero-subtitle { margin-left: auto; margin-right: auto; }
            .hero-actions { justify-content: center; }
            .hero-visual { order: -1; }
            .phone-device { width: 230px; }
            .phone-frame { transform: none; }
            .phone-frame:hover { transform: none; }
            .float-badge { display: none; }
            .features-grid { grid-template-columns: 1fr; max-width: 480px; margin: 0 auto; }
            .steps-row { grid-template-columns: 1fr; max-width: 360px; margin: 3.5rem auto 0; }
            .steps-row::before { display: none; }
            .categories-grid { grid-template-columns: repeat(3, 1fr); }
            .app-showcase-inner { grid-template-columns: 1fr; text-align: center; gap: 3rem; }
            .app-showcase-visual { order: -1; }
            .checklist { max-width: 400px; margin: 2rem auto 0; }
            .testimonials-grid { grid-template-columns: 1fr; max-width: 480px; margin: 3rem auto 0; }
            .stats-inner { grid-template-columns: repeat(2, 1fr); gap: 1.5rem; }
            .nav-links { display: none; }
            .mobile-menu-btn { display: block; }
            .cta-buttons { flex-direction: column; align-items: center; }
            .footer-inner { flex-direction: column; text-align: center; }
            .footer-links { justify-content: center; }
        }
        @media (max-width: 480px) {
            .categories-grid { grid-template-columns: repeat(2, 1fr); }
        }
    </style>
</head>
<body>

    {{-- ═══ Navigation ═══ --}}
    <nav class="nav" id="nav">
        <div class="nav-inner">
            <a href="/" class="nav-logo">
                <img src="{{ asset('images/logo.png') }}" alt="Asif Groceries" width="46" height="46">
                <span class="nav-logo-text">Asif Groceries</span>
            </a>
            <ul class="nav-links">
                <li><a href="#features">Features</a></li>
                <li><a href="#how-it-works">How It Works</a></li>
                <li><a href="#categories">Categories</a></li>
                <li><a href="{{ route('privacy-policy') }}">Privacy</a></li>
                <li><a href="#download" class="nav-cta">Download App</a></li>
            </ul>
            <button class="mobile-menu-btn" aria-label="Menu"><span></span><span></span><span></span></button>
        </div>
    </nav>

    {{-- ═══ Hero ═══ --}}
    <section class="hero">
        <div class="hero-inner">
            <div>
                <div class="hero-badge">
                    <span class="hero-badge-dot"></span>
                    Now delivering across Model Town and nearby areas
                </div>
                <h1>Fresh groceries,<br><span>delivered fast.</span></h1>
                <p class="hero-subtitle">
                    Order daily essentials, fresh produce, and household items from Asif Groceries. We deliver straight to your doorstep across Model Town and nearby areas.
                </p>
                <div class="hero-actions">
                    <a href="#download" class="btn-primary">
                        <svg xmlns="http://www.w3.org/2000/svg" width="18" height="18" viewBox="0 0 512 512" fill="currentColor"><path d="M325.3 234.3L104.6 13l280.8 161.2-60.1 60.1zM47 0C34 6.8 25.3 19.2 25.3 35.3v441.3c0 16.1 8.7 28.5 21.7 35.3l256.6-256L47 0zm425.2 225.6l-58.9-34.1-65.7 64.5 65.7 64.5 60.1-34.1c18-14.3 18-46.5-1.2-60.8zM104.6 499l280.8-161.2-60.1-60.1L104.6 499z"/></svg>
                        Get the App
                    </a>
                    <a href="#features" class="btn-secondary">Learn More ↓</a>
                </div>
            </div>
            <div class="hero-visual">
                <div class="float-badge tl">
                    <div class="float-badge-icon fb-green">🥬</div>
                    <div>
                        <div style="font-size:0.72rem;color:var(--text-light);">Fresh Produce</div>
                        <div style="font-size:0.82rem;font-weight:700;">Just Arrived</div>
                    </div>
                </div>
                <div class="float-badge br">
                    <div class="float-badge-icon fb-blue">🚀</div>
                    <div>
                        <div style="font-size:0.72rem;color:var(--text-light);">Delivery</div>
                        <div style="font-size:0.82rem;font-weight:700;">Fast & Reliable</div>
                    </div>
                </div>
                <div class="phone-device">
                    <div class="phone-frame">
                        <img src="{{ asset('images/app-screenshot.png') }}" alt="Asif Groceries App" loading="eager">
                    </div>
                </div>
            </div>
        </div>
    </section>

    {{-- ═══ Stats ═══ --}}
    <section class="stats-bar">
        <div class="stats-inner reveal">
            <div class="stat-item">
                <div class="stat-number">500+</div>
                <div class="stat-label">Products Available</div>
            </div>
            <div class="stat-item">
                <div class="stat-number">6</div>
                <div class="stat-label">Categories</div>
            </div>
            <div class="stat-item">
                <div class="stat-number">Fast</div>
                <div class="stat-label">Same-Day Delivery</div>
            </div>
            <div class="stat-item">
                <div class="stat-number">24/7</div>
                <div class="stat-label">Order Anytime</div>
            </div>
        </div>
    </section>

    {{-- ═══ Features ═══ --}}
    <section class="features" id="features">
        <div class="section-inner">
            <span class="section-label">Why Choose Us</span>
            <h2 class="section-title">Everything you need,<br>delivered with care.</h2>
            <p class="section-desc">We handpick fresh produce and deliver daily essentials right to your home.</p>
            <div class="features-grid reveal">
                <div class="feature-card">
                    <div class="feature-icon">🥬</div>
                    <h3>Farm Fresh Produce</h3>
                    <p>We source directly from local farms to ensure you get the freshest fruits and vegetables.</p>
                </div>
                <div class="feature-card">
                    <div class="feature-icon">⚡</div>
                    <h3>Fast Delivery</h3>
                    <p>Reliable and prompt delivery to your doorstep across Model Town, Faisal Town & Garden Town, Lahore. Track your order in real-time.</p>
                </div>
                <div class="feature-card">
                    <div class="feature-icon">💰</div>
                    <h3>Best Prices</h3>
                    <p>Competitive pricing on all items. No hidden fees, no surprises — honest grocery shopping.</p>
                </div>
                <div class="feature-card">
                    <div class="feature-icon">📱</div>
                    <h3>Easy Ordering</h3>
                    <p>Browse categories, search products, add to cart — place your order in just a few taps.</p>
                </div>
                <div class="feature-card">
                    <div class="feature-icon">🔔</div>
                    <h3>Live Order Updates</h3>
                    <p>Push notifications at every step. From confirmation to dispatch and delivery.</p>
                </div>
                <div class="feature-card">
                    <div class="feature-icon">🔐</div>
                    <h3>Secure Sign-In</h3>
                    <p>Sign in with Google, phone OTP, or email. Your account and data are always safe.</p>
                </div>
            </div>
        </div>
    </section>

    {{-- ═══ How It Works ═══ --}}
    <section class="how-it-works" id="how-it-works">
        <div class="section-inner" style="text-align:center;">
            <span class="section-label">How It Works</span>
            <h2 class="section-title">Three simple steps.</h2>
            <div class="steps-row reveal">
                <div class="step">
                    <div class="step-number">1</div>
                    <h3>Browse & Add</h3>
                    <p>Explore categories and search for your favourite products. Add items to your cart.</p>
                </div>
                <div class="step">
                    <div class="step-number">2</div>
                    <h3>Checkout</h3>
                    <p>Choose your delivery address, review your order, and confirm — quick and easy.</p>
                </div>
                <div class="step">
                    <div class="step-number">3</div>
                    <h3>Get Delivered</h3>
                    <p>Sit back and relax. Our rider delivers your groceries fresh to your doorstep.</p>
                </div>
            </div>
        </div>
    </section>

    {{-- ═══ Categories ═══ --}}
    <section class="categories-section" id="categories">
        <div class="section-inner" style="text-align:center;">
            <span class="section-label">Shop By Category</span>
            <h2 class="section-title">Browse what you need.</h2>
            <div class="categories-grid reveal">
                <div class="cat-card"><div class="cat-emoji">🥤</div><div class="cat-name">Beverages</div></div>
                <div class="cat-card"><div class="cat-emoji">🧀</div><div class="cat-name">Dairy</div></div>
                <div class="cat-card"><div class="cat-emoji">🧹</div><div class="cat-name">Home Care</div></div>
                <div class="cat-card"><div class="cat-emoji">🐾</div><div class="cat-name">Pet Care</div></div>
                <div class="cat-card"><div class="cat-emoji">🍎</div><div class="cat-name">Fruits</div></div>
                <div class="cat-card"><div class="cat-emoji">🥕</div><div class="cat-name">Vegetables</div></div>
            </div>
        </div>
    </section>

    {{-- ═══ App Showcase ═══ --}}
    <section class="app-showcase">
        <div class="app-showcase-inner">
            <div class="app-showcase-visual reveal">
                <img src="{{ asset('images/app-screenshot.png') }}" alt="Asif Groceries App">
            </div>
            <div class="reveal">
                <span class="section-label">Why Download</span>
                <h2 class="section-title">Your grocery store,<br>in your pocket.</h2>
                <p style="font-size:1.05rem;color:var(--text-secondary);line-height:1.7;">
                    The Asif Groceries app makes grocery shopping effortless. Everything you need — from fresh produce to daily essentials — delivered to your door.
                </p>
                <ul class="checklist">
                    <li><span class="check-icon">✓</span> Browse 500+ products across 6 categories</li>
                    <li><span class="check-icon">✓</span> Real-time order tracking and push notifications</li>
                    <li><span class="check-icon">✓</span> Secure checkout with multiple sign-in options</li>
                    <li><span class="check-icon">✓</span> Save delivery addresses for quick reorder</li>
                    <li><span class="check-icon">✓</span> In-app wallet for fast payments</li>
                </ul>
            </div>
        </div>
    </section>

    {{-- ═══ Testimonials ═══ --}}
    <section class="testimonials">
        <div class="section-inner" style="text-align:center;">
            <span class="section-label">What Customers Say</span>
            <h2 class="section-title">Loved by shoppers around you.</h2>
            <div class="testimonials-grid reveal">
                <div class="testimonial-card">
                    <div class="testimonial-stars">★★★★★</div>
                    <p class="testimonial-text">"The app is so easy to use. I order my weekly groceries in minutes and they always deliver on time."</p>
                    <div class="testimonial-author">Ayesha K.</div>
                    <div class="testimonial-location">Model Town, Lahore</div>
                </div>
                <div class="testimonial-card">
                    <div class="testimonial-stars">★★★★★</div>
                    <p class="testimonial-text">"Fresh vegetables every time. The delivery rider is always polite and the packaging is excellent."</p>
                    <div class="testimonial-author">Usman M.</div>
                    <div class="testimonial-location">Faisal Town, Lahore</div>
                </div>
                <div class="testimonial-card">
                    <div class="testimonial-stars">★★★★★</div>
                    <p class="testimonial-text">"Finally a grocery app that actually works well in Lahore. Great prices and the delivery is quick."</p>
                    <div class="testimonial-author">Fatima R.</div>
                    <div class="testimonial-location">Garden Town, Lahore</div>
                </div>
            </div>
        </div>
    </section>

    {{-- ═══ CTA ═══ --}}
    <section class="cta-section" id="download">
        <img src="{{ asset('images/logo.png') }}" alt="Asif Groceries" class="cta-logo">
        <h2>Ready to order?</h2>
        <p>Download the Asif Groceries app and start shopping for fresh groceries today.</p>
        <div class="cta-buttons">
            <a href="https://play.google.com/store/apps/details?id=com.asifgroceries.app" target="_blank" rel="noopener" class="btn-white">
                <svg xmlns="http://www.w3.org/2000/svg" width="18" height="18" viewBox="0 0 512 512" fill="currentColor"><path d="M325.3 234.3L104.6 13l280.8 161.2-60.1 60.1zM47 0C34 6.8 25.3 19.2 25.3 35.3v441.3c0 16.1 8.7 28.5 21.7 35.3l256.6-256L47 0zm425.2 225.6l-58.9-34.1-65.7 64.5 65.7 64.5 60.1-34.1c18-14.3 18-46.5-1.2-60.8zM104.6 499l280.8-161.2-60.1-60.1L104.6 499z"/></svg>
                Google Play
            </a>
            <a href="mailto:ahmadomer@zegobyte.com" class="btn-outline-white">Contact Us →</a>
        </div>
    </section>

    {{-- ═══ Footer ═══ --}}
    <footer class="footer">
        <div class="footer-inner">
            <div class="footer-brand">
                <img src="{{ asset('images/logo.png') }}" alt="Asif Groceries" width="40" height="40">
                <span class="footer-brand-text">Asif Groceries</span>
            </div>
            <ul class="footer-links">
                <li><a href="{{ route('privacy-policy') }}">Privacy Policy</a></li>
                <li><a href="mailto:ahmadomer@zegobyte.com">Contact</a></li>
            </ul>
            <p class="footer-copy">&copy; {{ date('Y') }} Asif Groceries. All rights reserved.</p>
        </div>
    </footer>

    <script>
        // Nav scroll
        const nav = document.getElementById('nav');
        window.addEventListener('scroll', () => nav.classList.toggle('scrolled', window.scrollY > 40));

        // Smooth scroll
        document.querySelectorAll('a[href^="#"]').forEach(a => {
            a.addEventListener('click', e => {
                e.preventDefault();
                const t = document.querySelector(a.getAttribute('href'));
                if (t) t.scrollIntoView({ behavior: 'smooth', block: 'start' });
            });
        });

        // Scroll reveal
        const observer = new IntersectionObserver((entries) => {
            entries.forEach(e => { if (e.isIntersecting) { e.target.classList.add('visible'); observer.unobserve(e.target); } });
        }, { threshold: 0.15 });
        document.querySelectorAll('.reveal').forEach(el => observer.observe(el));
    </script>
</body>
</html>
