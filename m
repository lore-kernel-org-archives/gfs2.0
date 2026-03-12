Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38EAF1A6805
	for <gfs2@lists.linux.dev>; Thu, 12 Mar 2026 23:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773359545; cv=none; b=eMdMd9rGC2MH6h9nZTv71jmQkGRG7DXy/+58BEcZ554fGX4HA5u5FG0UAX7OAvkPPdufKH1o8NJY/wOG2jIesLBxpb7IaaHzQyD98DbN+2PdTpWLqWAvhqM5mI8m4fxty5YHziTZcKZ7x6UxgumxEN9ES6MPRjpw/C37fYxAJPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773359545; c=relaxed/simple;
	bh=wOUC16WI4/reo5GvoZO5ESmt8rfD7PE3++Xf9novjKE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=axrvcEANdW8iAI5ukuKCBzVWTmR/FiABT4mx7mkOAwsC/pUjD8l41pJq+CunrR77oZE96oWDt+c2plR55/Hj5NhNu6ykF+r2D8ThAlSIpOZYBjxIspspN272J+5P+d+UNJL2/rbLFJe0ADm1yyXBF2qRB5aaasqBeJR7/CMb82A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Hr+8itB9; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Hr+8itB9"
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-6611f41eebcso2127382a12.2
        for <gfs2@lists.linux.dev>; Thu, 12 Mar 2026 16:52:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1773359542; x=1773964342; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=pkgvHL0resGmXTqRBi16uC1NxLEncxIx9i+VLjGIXAo=;
        b=Hr+8itB9Y0Yio8A8N9MubmBCoorQhzs//Ztr5JEdhivSQlHW/SW6dNNdLRylED1Dqp
         aVxvBgkaIiNOjMXDt/nMRYhFaGjmOT2T4UdK8SqbyUusshtJwBVcNEHR5TJuToiFBtDu
         kHJPCN0XyRj0asg2ldDb8BiHgWuZp2DUkMO1s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773359542; x=1773964342;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pkgvHL0resGmXTqRBi16uC1NxLEncxIx9i+VLjGIXAo=;
        b=V5N7dTF7LcipV2IFXRQLamglVmNZ2/hcYU68lP0U9TgWujc5kxPcbyQOkYsD9+O+wr
         TVGjJB6/h1M46XeLLeOpygljOxogOX/5bfMg/tJHwGnHa26WxNeOhihH3V12SyW5q3RS
         7U/62NFCJj0Ovj4U6Vy9FPYMTP3X2CltEsMDLtadDIL+RBqUngghLWPKvZgzOy0VfqxH
         g8pETPuLI18HZuvm1/LETICl18W+bTT7p4Alvnwp0taGxqRGuUoAbZyCtjso+QSzAWV1
         8O3M5UzEXhT0YWv7LDsysL0TL2GJpuZ8SEAFLmWC3xkveL8inqmZW+7EFytQhYYFCi+g
         TRjg==
X-Forwarded-Encrypted: i=1; AJvYcCV/kht5iurhy9Mx3qoUN+LsGvUL9GY/I5v/zW6auMYmmJU0/lhiJN+DVzS71D3/Xx0tATAu@lists.linux.dev
X-Gm-Message-State: AOJu0YyJVIocVfOYbCtGKXVYXEDgm1IsVeJDNbU9kgZx6gQAB4NzyH4D
	Iz37tSo+w1EEJzYQjd8kqDMH6HEZvn9gZRIesmwiUIdLfwV3F2HA7AeB2wgubRrxN+u4JlKkVgO
	Rh1TAQLw=
X-Gm-Gg: ATEYQzxOoGmW9BZli9ac/jT4a5AxT0j4OgOw/jE1Y+hYl9pS7Z7l5WpOxEJlEopM/Vx
	8j6+Y5h7i7CTPMMZzBOuS6I+i62LjekObPxLU45NMzQjYVhmQ7F/yflXUycJmC2zTLUNNk9l3g6
	/9ggin5nfKnGjREeMeHMI4ACxEbymHMNQMJ7OuM9MMCZadiOQy9E8BF+ccxEHwECMh6cPnqheMZ
	JKdW0BIs5O/YwdI0ZQk5mnuJ+3Rnxrpf0Y+NG5wOE9Pi9F0GGoxerrsUvaIixar2U5rJhAyoL/e
	LT64d3zPdyJe6/mt8TxC3DLkk6vkOytcIa0I5HBOxU0uUaA/2+OICDSddyfIr+r3azFQREUT2JH
	f1Bb2eHD0KOdy8vMbMOAE/0xCqjY2GAliKJvcqZINqH6AoNwMFbLrETpGaPQR9sgetOd+haghz2
	rmOivoGpqC+MQrObBvnuieYR+1ZWq06vGpTVMYMHi716qkxODQGuZcbKEeEDQPeFJGQJIeiUtP
X-Received: by 2002:a05:6402:254c:b0:660:bf7d:ce58 with SMTP id 4fb4d7f45d1cf-663bac00405mr640204a12.16.1773359542453;
        Thu, 12 Mar 2026 16:52:22 -0700 (PDT)
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com. [209.85.218.53])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6634fbb9b89sm929067a12.7.2026.03.12.16.52.22
        for <gfs2@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Mar 2026 16:52:22 -0700 (PDT)
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-b96f02b4329so272438766b.2
        for <gfs2@lists.linux.dev>; Thu, 12 Mar 2026 16:52:22 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVDVNniJczDovxX6OJU837jYVsDzDAvqvp9Ak47EyXUF9Dp1syNV23RncHqXc2oqekqnV3T@lists.linux.dev
X-Received: by 2002:a17:907:c5c9:b0:b96:d802:8b41 with SMTP id
 a640c23a62f3a-b9764fd8722mr66207066b.15.1773359215961; Thu, 12 Mar 2026
 16:46:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260312214330.3885211-1-neilb@ownmail.net>
In-Reply-To: <20260312214330.3885211-1-neilb@ownmail.net>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 12 Mar 2026 16:46:39 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh92deXvH5iXCo9mThXCBYt-jRcVu=z4kiH-f3+wZQOHA@mail.gmail.com>
X-Gm-Features: AaiRm503fTaccEgKNbxF9h_dDHM9fUsSr52XJuxzTwCI0G9L03uDq8g5di1zchk
Message-ID: <CAHk-=wh92deXvH5iXCo9mThXCBYt-jRcVu=z4kiH-f3+wZQOHA@mail.gmail.com>
Subject: Re: [PATCH RFC 00/53] lift lookup out of exclive lock for dir ops
To: NeilBrown <neil@brown.name>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Jeff Layton <jlayton@kernel.org>, Trond Myklebust <trondmy@kernel.org>, 
	Anna Schumaker <anna@kernel.org>, Carlos Maiolino <cem@kernel.org>, Miklos Szeredi <miklos@szeredi.hu>, 
	Amir Goldstein <amir73il@gmail.com>, Jan Harkes <jaharkes@cs.cmu.edu>, 
	Hugh Dickins <hughd@google.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	David Howells <dhowells@redhat.com>, Marc Dionne <marc.dionne@auristor.com>, 
	Steve French <sfrench@samba.org>, Namjae Jeon <linkinjeon@kernel.org>, 
	Sungjong Seo <sj1557.seo@samsung.com>, Yuezhang Mo <yuezhang.mo@sony.com>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Breno Leitao <leitao@debian.org>, "Theodore Ts'o" <tytso@mit.edu>, 
	Andreas Dilger <adilger.kernel@dilger.ca>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Ilya Dryomov <idryomov@gmail.com>, 
	Alex Markuze <amarkuze@redhat.com>, Viacheslav Dubeyko <slava@dubeyko.com>, Tyler Hicks <code@tyhicks.com>, 
	Andreas Gruenbacher <agruenba@redhat.com>, Richard Weinberger <richard@nod.at>, 
	Anton Ivanov <anton.ivanov@cambridgegreys.com>, Johannes Berg <johannes@sipsolutions.net>, 
	Jeremy Kerr <jk@ozlabs.org>, Ard Biesheuvel <ardb@kernel.org>, linux-fsdevel@vger.kernel.org, 
	linux-nfs@vger.kernel.org, linux-xfs@vger.kernel.org, 
	linux-unionfs@vger.kernel.org, coda@cs.cmu.edu, linux-mm@kvack.org, 
	linux-afs@lists.infradead.org, linux-cifs@vger.kernel.org, 
	linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, ceph-devel@vger.kernel.org, 
	ecryptfs@vger.kernel.org, gfs2@lists.linux.dev, linux-um@lists.infradead.org, 
	linux-efi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 12 Mar 2026 at 14:44, NeilBrown <neilb@ownmail.net> wrote:
>
> This patch set progresses my effort to improve concurrency of
> directory operations and specifically to allow concurrent updates
> in a given directory.

I only got about half the patches, but the ones I did get didn't raise
my hackles.

HOWEVER.

This is very much a "absolutely requires ACKs from Al" series. Al?

Also, because I only got about half the patches, and there's 53 of
them total, I'd really like to see a git branch for something like
this. It makes it easier to review for me, and I suspect it makes it
easier for some of the test robots too.

But again - this needs Al to look at it. Iirc he had some fundamental
concern with the last version - hopefully now fixed, but ...

                 Linus
