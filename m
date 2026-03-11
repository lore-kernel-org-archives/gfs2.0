Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 902753CEBBC
	for <gfs2@lists.linux.dev>; Wed, 11 Mar 2026 10:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773225271; cv=none; b=u7bV+BTMevWaMYqEcxkVJnmU0eCNIOu8ap4EwL0vgAUskSIp3xqrGDWcnf4SeqP2PBB4aDN7ZlEMolTxAUf5YGgPt4tIPMWMC3qF0rUxNNDxwGSn/5zwu+e9jeLzpA9KIUhdfvLOHUJygal3Ro1DIeQlMUJNoccpKaEb9dXjSKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773225271; c=relaxed/simple;
	bh=+lt/Tud5kdWa9caCp9BWChC8IZmh9vX+/c/JTZN/syM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EEebqF49HLrO42meX9E57lv8IqdbfKY7CPdgrtceFOU/77tQrR5IFdxK966RsJ5fsxF/rC6LPYn4TVpKUd7LJ7oTQk6LA38i8NmbUyQVzR22nooCxIZHoyKY6hQI/L8GTrq8LBWcEv4YT6U4KsMmstQkNQBuPo2iFBHVd+XkmME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=sZ1CadJy; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="sZ1CadJy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1B96C4CEF7;
	Wed, 11 Mar 2026 10:34:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1773225271;
	bh=+lt/Tud5kdWa9caCp9BWChC8IZmh9vX+/c/JTZN/syM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sZ1CadJyqWlXdi13rNN8erC1RFTPiATGhHtewk5blEzMxufLQsJSiC9AKM5/EkfbP
	 uNjwD4s7Onr9xkXac/axvncFKrTtHq3YdnR47DDAlRxEyCb+eIrxj0jUD7rKUlxm4p
	 eSafa3HEO9UCkUqRvQ2acPBIpbR1/MuVGTcjkc5o=
Date: Wed, 11 Mar 2026 11:34:26 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: can-yildirim@ymail.ne.jp
Cc: "security@kernel.org" <security@kernel.org>,
	"gfs2@lists.linux.dev" <gfs2@lists.linux.dev>,
	"aahringo@redhat.com" <aahringo@redhat.com>,
	"teigland@redhat.com" <teigland@redhat.com>
Subject: Re: Re: [vs] DLM debugfs information disclosure via
 non-null-terminated resource name
Message-ID: <2026031131-botanist-babbling-b8d2@gregkh>
References: <173757593.643632.1773164229041.ref@mail.yahoo.co.jp>
 <173757593.643632.1773164229041@mail.yahoo.co.jp>
 <2098115699.650906.1773192682434@mail.yahoo.co.jp>
 <2026031118-shower-darkened-3e3a@gregkh>
 <752863286.16555.1773224814491@mail.yahoo.co.jp>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <752863286.16555.1773224814491@mail.yahoo.co.jp>

On Wed, Mar 11, 2026 at 07:26:54PM +0900, can-yildirim@ymail.ne.jp wrote:
> Hey Greg,
> Nice to meet you...

Hi, and note, why the [vs] in the subject line?  This isn't vendor-sec,
that list is long gone.  What caused that to show up here?

> > 日時：2026/03/11 水 15:42
> > 件名：Re: [vs] DLM debugfs information disclosure via non-null-terminated resource name
> > 
> > 
> > On Wed, Mar 11, 2026 at 10:31:22AM +0900, can-yildirim@ymail.ne.jp wrote:
> > > Dear maintainers,
> > > There is an possible information disclosure vulnerability in the DLM
> > > subsystem's debugfs interface.
> > 
> > debugfs is, by default, only readable by root, and contains loads of
> > stuff like this, as it's full of debug information on the system.  So
> > much so that many systems do not enable it in their kernels, and others
> > do not mount it at all.  So it's not really a problem overall from a
> > security point of view.
> > 
> > > The issue resides in the function
> > > print_format2_lock() in fs/dlm/debug_fs.c. When a resource name
> > > is exactly DLM_RESNAME_MAXLEN bytes long and contains no null
> > > byte, the %s format specifier in a seq_printf call reads beyond
> > > the intended buffer, exposing adjacent kernel memory.
> > 
> > That's not good, can you just send a patch for this to the developers
> > and mailing list and they can apply it like normal?
> > 
> > thanks,
> > 
> > greg k-h
> > 
> While debugfs is indeed root-only and often disabled, this vulnerability specifically targets environments that do enable it and cannot migrate to userspace coordination systems like ZooKeeper or Redis due to resource constraints or legacy requirements. In those clustered environments (e.g., HPC, Pacemaker/DRBD setups), DLM is actively used, debugfs is present, and local root access can be chained with this leak to bypass KASLR and facilitate further exploitation. So while the overall risk is low, the impact in the specific niche where this code actually runs is real.

If you have local root access, heck, just local access, KASLR is
trivially leaked, that is not what KASLR is trying to protect from at
all.

> On top of this, I would also suggest you looking at things i can`t even spell it`s name right once; IBM s390x architectures like(IBM Z/LinuxONE). These systems cost like hundreds of thousands to $15M+, and they power the world basically[Not an IBM advertisement btw, just some sprinkles]. 
> On these platforms, stability and backward compatibility is nirvana dude,and you can't just "rewrite everything to use ZooKeeper". or build your own program[Was it chubby?chobby?chobani maybe idk] like Google did because they can. The kernel DLM is on the environments built and relied upon, debugfs is often present. A KASLR bypass on these systems isn't just an academic exercise... It's a real domino step towards to an infrastructure that literally cannot afford downtime, but still, some device like this somewhere in the world probably depends more or less on what you're currently probably laughing at, anyways...

I do not understand what you are trying to say here at all, sorry.

> So in short while this may seem like "just another debugfs something something something" from a desktop Linux perspective, the impact profile changes dramatically when you consider where this code actually runs in production.

Then those production systems have worse problems if they are letting a
local root user do whatever they want.

> Also, i am not going to write or commit an patch, i wrote somethings about that but decision to commit/implement is something i don`t care at the moment.

Please submit a patch if you feel this is something that should be fixed
up.

thanks,

greg k-h
