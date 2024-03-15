Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 469B43B18C
	for <gfs2@lists.linux.dev>; Fri, 15 Mar 2024 17:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710522622; cv=none; b=MuATS8llOCM9bZSj1MwPPSQkLEKnizc1+VRkWIj2Zdq0vNBzSXeVt88GP1Pe52dnmvQp+lQm3mPFGybUQwWYFFNy+dcp6qoMxE9PJY0Al5UWjvGdQ3+Ub+wzBMJEOI4+Y3AFHTl6REajrll84alZbZa47rDy6FXI/xDVnVWRWeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710522622; c=relaxed/simple;
	bh=6DEC6oUBwOJ1z2N6TU7EEu2WviwhfCWFHXvtFC7nPjY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SRsD2rYikNofdbC30FWcZ3KfYKf04tpdqOg3lHklD7OKvitibZBJfjo6Qnk6pt2RMK+SJsMe5NdZb8TrG3JIjZijJR7x4lEgfQxLzjoKSIpCWoICzQd7ZGA1xiSHE0JwRW7HoX+21ag/4QeB0x5g4mElIKNGdz7NPp1CLss/PqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=doeEquFs; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="doeEquFs"
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2d28387db09so31803111fa.0
        for <gfs2@lists.linux.dev>; Fri, 15 Mar 2024 10:10:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1710522618; x=1711127418; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=NlJklAI6AGoIIJ5Y8J8C9xRkI2A04dQCtN2O9+qMSZk=;
        b=doeEquFs+fQt4Hm5eYgAvKZsJFLsxg6A7ObDt0ogcZdjqMXLA2BnOJXJuoFot1oXuw
         v4zMCrOc5CrlgGj6JlwlCIOxWl+AIMpoan+iKD+M28CtMVSX+4OO3HvFJLCunH/uwTD0
         bIz8OQrMzM8Ht8Vgayg0yPhPeBkbOmy9IurMI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710522618; x=1711127418;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NlJklAI6AGoIIJ5Y8J8C9xRkI2A04dQCtN2O9+qMSZk=;
        b=AOIVNfsYWZZmHRqUgLyefIMq2j7DxjXXGaHutM7Lu4xv5gZAZuK0B6lQI43aVn9wyb
         TdeY6VNZGEXyY2dinNnpVd4rJAH7fSNXLyzLt7F45VAxoV88R9gET3y+iIqYUIUd1N/H
         mMcyH0mJxBN/HC07vYaLm6z6vRmys77npl51YqJgpkG2X+NSdz+LE98MZ0+FjNI7Jkba
         HUjuL3tMW5fPa7dAvdaBWX54xBblY2G0KL/nbCpGxSfP7D/t2bFmsHLcddUeuJAFGdI8
         hMLdmE3fGagxZf8fBADT4m/N81HE0q1DMo1mhd0+c44ll6jAdvMCV+pdctg1ckNGrw1u
         xCOA==
X-Forwarded-Encrypted: i=1; AJvYcCX80qPQjo74odukF3ZY+yXCC26I4g9toHxP6oiAlbd4HzRH+IE6XLOHAwF6ZiJtmvjtZISRgkh9Sjn+AuvhtfSi053hfg==
X-Gm-Message-State: AOJu0YzTVSRh8sV6Cuc9oaa8i7Lzyvg9QT/bg9/+agTARj/M6q9+tpsJ
	hAHN/9E1pcSAIylosUQ6scbA96FICJARZ62X1UDw2wo8LcvOf17f/RdOmlc/dOcPlbJbpv7DS0q
	qlus=
X-Google-Smtp-Source: AGHT+IFobyJbgbka9TW1dGDBsb6X1lLT1/d+NdKwuhpLI997W260poiDgriuvJMmYAyQJvy6ZKkITA==
X-Received: by 2002:a2e:88d4:0:b0:2d2:dac3:90f with SMTP id a20-20020a2e88d4000000b002d2dac3090fmr2208140ljk.52.1710522617954;
        Fri, 15 Mar 2024 10:10:17 -0700 (PDT)
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com. [209.85.218.49])
        by smtp.gmail.com with ESMTPSA id eo14-20020a056402530e00b00568a1897dbesm1643700edb.77.2024.03.15.10.10.17
        for <gfs2@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Mar 2024 10:10:17 -0700 (PDT)
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a44ad785a44so279045866b.3
        for <gfs2@lists.linux.dev>; Fri, 15 Mar 2024 10:10:17 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWVkhp/+jG0UwEgiX+XiWW9UKrTweQj0VMFr4+D0QNOf7+x7pJaEMKoeMjXRaOQcHoDjExOJ3p4k6JNL7DW2ta6T8yIdQ==
X-Received: by 2002:a17:906:550:b0:a46:d8:1690 with SMTP id
 k16-20020a170906055000b00a4600d81690mr2346753eja.69.1710522616736; Fri, 15
 Mar 2024 10:10:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <ZfNFRg-KxTCTPf92@redhat.com>
In-Reply-To: <ZfNFRg-KxTCTPf92@redhat.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 15 Mar 2024 10:10:00 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh4qK+zHrrYehidKRp4Fi6e4qUD6Tv6Ed8USxUC+H+HrQ@mail.gmail.com>
Message-ID: <CAHk-=wh4qK+zHrrYehidKRp4Fi6e4qUD6Tv6Ed8USxUC+H+HrQ@mail.gmail.com>
Subject: Re: [GIT PULL] dlm fixes for 6.9
To: David Teigland <teigland@redhat.com>
Cc: linux-kernel@vger.kernel.org, gfs2@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

On Thu, 14 Mar 2024 at 11:43, David Teigland <teigland@redhat.com> wrote:
>
> Fix two refcounting bugs from recent changes:
> - misuse of atomic_dec_and_test results in missed ref decrement
> - wrong variable assignment results in another missed ref decrement

I pulled this, and then I unpulled it again.

That code is insane.

This is *NOT* sane or valid code:

+               while (atomic_read(&lkb->lkb_wait_count)) {
+                       if (atomic_dec_and_test(&lkb->lkb_wait_count))
+                               list_del_init(&lkb->lkb_wait_reply);
+
+                       unhold_lkb(lkb);
+               }

the above is completely crazy. That's simply not how atomics work.

What's the point of using a refcount - an atomic one at that - if you
just use it as a counter. That's not a "reference count", that's
literally just broken.

The whole - and *ONLY* - point of a refcount is that you are counting
references. References that *YOU* hold. Not that somebody else is
holding and you are releasing.

If you're the only holder of any counts, don't make them atomic, don't
put them in a data structure. But you're *not* the only holder fo that
refcount here, are you?

Using atomics for this kind of sequence shows some crazy crazy
behavior. It's not valid to say "ok, as long as this atomic is not
zero, let's decrement it and test if it's not zero".

Because for an atomic value to MAKE SENSE IN THE FIRST PLACE, there
could be somebody else that comes in and also possibly decrements it.

And if that happens between the test of "is this zero" and "did I
decrement it to zero", you now had two decrements, and that value is
now negative. So you didn't really have an atomic value, because you
did two operations on it.

And dammit, if that mutex means that it cannot happen, then WHY WAS IT
AN ATOMIC IN THE FIRST PLACE?

IOW, if you have locking that protects the value, then atomic accesses
are STILL wrong.

So there is not a single situation where I can see the above kind of
code ever being valid.

Now, if the issue is that you want to clean up something that is never
getting cleaned up by anybody else, and this is a fatal error, and
you're just trying to fix things up (badly), and you know that this is
all racy but the code is trying to kill a dead data structure, then
you should

 (a) need a damn big comment (bigger than the comment is already)

 (b) should *NOT* pretend to do some stupid "atomic decrement and test" loop

IOW, if what you want to do is get rid of stuck entries and set the
refcount to zero, then doing that would probably be something like

        /* This is broken, but.. */
        stale = atomic_xchg((&lkb->lkb_wait_count, 0);
        if (stale) {
                list_del_init(&lkb->lkb_wait_reply);
                do { unhold_lkb(lkb); } while (--stale);
        }

and it needs a much bigger comment than that "This is broken".

(And I don't know if you want that list_del_init() before or after the
'unhold N times' loop).

The above is still completely broken, but at least it doesn't do some
kind of odd non-atomic test and decrement stuff in a loop, and
hopefully makes it clear that we're very much talking about fixing up
stale final values

And no, I didn't look at the code around it. Because I really think
that "while (atomic_read(...)" loop cannot POSSIBLY be correct,
regardless of any context.

                Linus
